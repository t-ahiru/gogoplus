<?php

namespace App\Notifications;

use App\Models\DataRequest;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\DatabaseMessage;
use Illuminate\Support\Facades\Log;

class DataRequestShared extends Notification
{
    use Queueable;

    protected $dataRequest;

    public function __construct($dataRequest)
    {
        $this->dataRequest = $dataRequest;
    }

    public function via($notifiable)
    {
        return ['database'];
    }

    public function toDatabase($notifiable)
    {
        $responseData = json_decode($this->dataRequest->response_data, true);
        $pdfUrl = $responseData['data']['pdf_url'] ?? null;

        Log::info('DataRequest value: ' . $this->dataRequest);

        return new DatabaseMessage([
            'message' => "A data request for {$this->dataRequest->request_type} has been shared with you by Admin.",
            'data_request_id' => $this->dataRequest->id,
            'pdf_url' => $pdfUrl,
            'shared_by' => 'Admin',
        ]);
    }
}