<?php

namespace App\Jobs;

use App\Models\DataRequest;
use App\Models\Pharmacy;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class SendApiRequest implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $dataRequest;

    public function __construct(DataRequest $dataRequest)
    {
        $this->dataRequest = $dataRequest;
    }

    public function handle()
    {
        $pharmacy = $this->dataRequest->pharmacy;

        try {
            $response = Http::withToken($pharmacy->api_key)
                ->timeout(30)
                ->post($pharmacy->api_endpoint, [
                    'request_type' => $this->dataRequest->request_type,
                    'details' => $this->dataRequest->details,
                    'request_id' => $this->dataRequest->id,
                ]);

            if ($response->successful()) {
                $this->dataRequest->update([
                    'status' => 'completed',
                    'response_data' => json_encode($response->json()),
                ]);
            } else {
                $this->dataRequest->update(['status' => 'failed']);
                Log::error('API request failed', ['response' => $response->body()]);
            }
        } catch (\Exception $e) {
            $this->dataRequest->update(['status' => 'failed']);
            Log::error('API request exception', ['error' => $e->getMessage()]);
        }
    }
}