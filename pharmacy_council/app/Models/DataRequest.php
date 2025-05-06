<?php

  namespace App\Models;

  use Illuminate\Database\Eloquent\Factories\HasFactory;
  use Illuminate\Database\Eloquent\Model;

  class DataRequest extends Model
  {
      use HasFactory;

      protected $fillable = [
          'pharmacy_id',
          'request_type',
          'details',
          'status',
          'response_data',
          'file_path',
      ];

      public function pharmacy()
      {
          return $this->belongsTo(Pharmacy::class);
      }
  }