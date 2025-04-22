<?php

namespace App\Http\Controllers;

use App\Models\Pharmacy;
use App\Models\DataRequest;
use App\Jobs\SendApiRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class DataRequestController extends Controller
{
    // Show form to create a new request
    public function create()
    {
        $pharmacies = Pharmacy::all();
        return view('data_requests.create', compact('pharmacies'));
    }

    // Send API request to a pharmacy
    public function sendRequest(Request $request)
    {
        $request->validate([
            'pharmacy_id' => 'required|exists:pharmacies,id',
            'request_type' => 'required|string|max:255',
            'details' => 'nullable|string',
        ]);
    
        $pharmacy = Pharmacy::findOrFail($request->pharmacy_id);
    
        if (!$pharmacy->hasApiConfigured()) {
            Log::warning("API request attempted for pharmacy ID {$pharmacy->id} with no API endpoint configured.");
            return redirect()->back()->with('error', 'Pharmacy API endpoint or key not configured.');
        }
    
        $dataRequest = DataRequest::create([
            'pharmacy_id' => $pharmacy->id,
            'request_type' => $request->request_type,
            'details' => $request->details,
            'status' => 'pending',
        ]);
    
        SendApiRequest::dispatch($dataRequest);
    
        return redirect()->back()->with('success', 'Request queued for sending.');
    }

    // List all requests (optional, for monitoring)
    public function index()
    {
        $dataRequests = DataRequest::with('pharmacy')->paginate(10); // 10 items per page
        return view('data_requests.index', compact('dataRequests'));
    }
}