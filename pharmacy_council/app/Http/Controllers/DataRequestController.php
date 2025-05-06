<?php

namespace App\Http\Controllers;

use App\Models\DataRequest;
use App\Models\DataRequestShare;
use App\Models\Pharmacy;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class DataRequestController extends Controller
{
    public function create()
    {
        if (auth()->user()->role_id !== 1) {
            return redirect()->back()->with('error', 'Only admins can create data requests.');
        }

        $pharmacies = Pharmacy::all();

        return view('data_requests.create', compact('pharmacies'));
    }

    public function sendRequest(Request $request)
    {
        $request->validate([
            'pharmacy_id' => 'required|exists:pharmacies,id',
            'request_type' => 'required|string|max:255',
            'details' => 'nullable|string',
        ]);

        $pharmacy = Pharmacy::findOrFail($request->pharmacy_id);

        if (!$pharmacy->hasApiConfigured()) {
            Log::warning("API request attempted for pharmacy ID {$pharmacy->id} with no API endpoint configured.", [
                'api_endpoint' => $pharmacy->api_endpoint,
                'api_key' => $pharmacy->api_key,
            ]);
            return redirect()->back()->with('error', 'Pharmacy API endpoint or key not configured.');
        }

        if (is_null($pharmacy->api_endpoint)) {
            Log::error("API endpoint is null for pharmacy ID {$pharmacy->id} despite passing hasApiConfigured check.");
            return redirect()->back()->with('error', 'Pharmacy API endpoint is not configured.');
        }

        $dataRequest = DataRequest::create([
            'pharmacy_id' => $pharmacy->id,
            'request_type' => $request->request_type,
            'details' => $request->details,
            'status' => 'pending',
        ]);

        try {
            $payload = [
                'request_type' => $dataRequest->request_type,
                'details' => $dataRequest->details,
                'request_id' => $dataRequest->id,
            ];
            Log::info("Sending API request for pharmacy ID {$pharmacy->id}", ['payload' => $payload]);
            $response = Http::withToken($pharmacy->api_key)
                ->timeout(30)
                ->post($pharmacy->api_endpoint, $payload);

            $pharmacy->update([
                'api_status' => $response->successful() ? 'active' : 'inactive',
                'last_api_request_at' => now(),
            ]);

            if ($response->successful()) {
                $responseData = $response->json();
                Log::info("API response for pharmacy ID {$pharmacy->id}", ['response' => $responseData]);
                if (isset($responseData['data']['pdf_url'])) {
                    $pdfUrl = trim($responseData['data']['pdf_url']);
                    $pdfUrl = str_replace('{{request.body.request_type | lowercase}}', strtolower($dataRequest->request_type), $pdfUrl);
                    Log::info("Validating PDF URL for pharmacy ID {$pharmacy->id}: {$pdfUrl}");
                    if (preg_match('/^https?:\/\/[^\s\/$.?#].[^\s]*$/', $pdfUrl)) {
                        $dataRequest->update([
                            'status' => 'approved',
                            'response_data' => json_encode($responseData),
                        ]);
                        return redirect()->back()->with('success', 'Data request sent and approved successfully.');
                    } else {
                        $dataRequest->update([
                            'status' => 'rejected',
                            'response_data' => json_encode($responseData),
                        ]);
                        Log::warning("Data request rejected for pharmacy ID {$pharmacy->id}: Invalid PDF URL.", [
                            'pdf_url' => $pdfUrl,
                            'response' => $responseData
                        ]);
                        return redirect()->back()->with('error', 'Data request was rejected due to an invalid PDF URL.');
                    }
                } else {
                    $dataRequest->update([
                        'status' => 'rejected',
                        'response_data' => json_encode($responseData),
                    ]);
                    Log::warning("Data request rejected for pharmacy ID {$pharmacy->id}: PDF URL missing.", ['response' => $responseData]);
                    return redirect()->back()->with('error', 'Data request was rejected due to missing PDF URL.');
                }
            } else {
                $dataRequest->update(['status' => 'failed']);
                Log::error('API request failed', ['response' => $response->body()]);
                return redirect()->back()->with('error', 'Data request failed due to an API error.');
            }
        } catch (\Exception $e) {
            $pharmacy->update([
                'api_status' => 'inactive',
                'last_api_request_at' => now(),
            ]);
            $dataRequest->update(['status' => 'failed']);
            Log::error('API request exception', ['error' => $e->getMessage(), 'pharmacy_id' => $pharmacy->id]);
            return redirect()->back()->with('error', 'Data request failed: ' . $e->getMessage());
        }
    }

    public function receiveResponse(Request $request, $id)
    {
        // Find the data request
        $dataRequest = DataRequest::findOrFail($id);

        // Get the authenticated pharmacy (via API token)
        $pharmacy = auth()->user();

        // Ensure the pharmacy matches the data request
        if (!$pharmacy || $pharmacy->id !== $dataRequest->pharmacy_id) {
            Log::warning("Unauthorized attempt to send response for data request ID {$id}", [
                'pharmacy_id' => $pharmacy ? $pharmacy->id : null,
                'data_request_pharmacy_id' => $dataRequest->pharmacy_id,
            ]);
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized: You are not allowed to respond to this data request.',
            ], 403);
        }

        // Validate the request
        $request->validate([
            'response_data' => 'nullable|array',
            'file' => 'nullable|file|max:10240', // Max 10MB
        ]);

        // Handle file upload (if provided)
        $filePath = null;
        if ($request->hasFile('file')) {
            $file = $request->file('file');
            $filePath = $file->store('responses', 'public');
            Log::info("File uploaded for data request ID {$id}", [
                'file_path' => $filePath,
                'file_name' => $file->getClientOriginalName(),
            ]);
        }

        // Update the data request with the response
        $responseData = $request->input('response_data', []);
        $dataRequest->update([
            'status' => 'completed', // New status to indicate the pharmacy responded
            'response_data' => json_encode($responseData),
            'file_path' => $filePath,
        ]);

        // Optionally notify the admin
        $admin = User::where('role_id', 1)->first();
        if ($admin) {
            $admin->notify(new \App\Notifications\DataRequestResponded($dataRequest));
        }

        Log::info("Response received for data request ID {$id}", [
            'pharmacy_id' => $pharmacy->id,
            'response_data' => $responseData,
            'file_path' => $filePath,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Response received successfully.',
            'data' => [
                'data_request_id' => $dataRequest->id,
                'file_path' => $filePath ? Storage::url($filePath) : null,
            ],
        ], 200);
    }

    public function index()
    {
        $dataRequests = DataRequest::with('pharmacy')->paginate(10);
        return view('data_requests.index', compact('dataRequests'));
    }

    public function shareForm($id)
    {
        if (auth()->user()->role_id !== 1) {
            return redirect()->back()->with('error', 'Only admins can share data requests.');
        }

        $dataRequest = DataRequest::with('pharmacy')->findOrFail($id);

        if ($dataRequest->status !== 'approved') {
            return redirect()->back()->with('error', 'Only approved data requests can be shared.');
        }

        if (!$dataRequest->pharmacy) {
            return redirect()->back()->with('error', 'Cannot share this data request: The associated pharmacy is missing.');
        }

        $users = User::where('id', '!=', auth()->id())->get();

        return view('data_requests.share', compact('dataRequest', 'users'));
    }

    public function share(Request $request, $id)
    {
        if (auth()->user()->role_id !== 1) {
            return redirect()->back()->with('error', 'Only admins can share data requests.');
        }

        $dataRequest = DataRequest::with('pharmacy')->findOrFail($id);

        if ($dataRequest->status !== 'approved') {
            return redirect()->back()->with('error', 'Only approved data requests can be shared.');
        }

        if (!$dataRequest->pharmacy) {
            return redirect()->back()->with('error', 'Cannot share this data request: The associated pharmacy is missing.');
        }

        $request->validate([
            'shared_with' => 'required|array',
            'shared_with.*' => 'exists:users,id',
        ]);

        foreach ($request->shared_with as $userId) {
            DataRequestShare::create([
                'data_request_id' => $dataRequest->id,
                'shared_by' => auth()->id(),
                'shared_with' => $userId,
            ]);

            $user = User::find($userId);
            $user->notify(new \App\Notifications\DataRequestShared($dataRequest));
        }

        return redirect()->route('data_requests.index')->with('success', 'Data request shared successfully.');
    }

    public function shared()
    {
        $sharedDataRequests = DataRequestShare::where('shared_with', auth()->id())
            ->with('dataRequest.pharmacy', 'sharedBy')
            ->get();

        return view('data_requests.shared', compact('sharedDataRequests'));
    }
}