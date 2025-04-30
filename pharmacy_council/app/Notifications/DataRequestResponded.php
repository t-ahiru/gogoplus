<?php

  namespace App\Notifications;

  use Illuminate\Bus\Queueable;
  use Illuminate\Notifications\Notification;
  use Illuminate\Notifications\Messages\MailMessage;

  class DataRequestResponded extends Notification
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

      public function toArray($notifiable)
      {
          return [
              'message' => "Pharmacy {$this->dataRequest->pharmacy->name} has responded to your data request (ID: {$this->dataRequest->id}).",
              'url' => route('data_requests.index'),
          ];
      }
  }