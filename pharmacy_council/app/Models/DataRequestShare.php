<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DataRequestShare extends Model
{
    protected $fillable = ['data_request_id', 'shared_by', 'shared_with', 'shared_at'];

    public function dataRequest()
    {
        return $this->belongsTo(DataRequest::class);
    }

    public function sharedBy()
    {
        return $this->belongsTo(User::class, 'shared_by');
    }

    public function sharedWith()
    {
        return $this->belongsTo(User::class, 'shared_with');
    }
}