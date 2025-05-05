<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;

class Purchase extends Model
{
    protected $connection = 'dynamic_connection';
    protected $table = 'purchases';

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }
}