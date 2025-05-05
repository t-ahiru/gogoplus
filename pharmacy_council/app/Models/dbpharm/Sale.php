<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;

class Sale extends Model
{
    protected $connection = null; // Dynamic connection
    protected $table = 'sales';

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id', 'id');
    }

    public function user()
    {
        return $this->belongsTo(\App\Models\User::class, 'user_id', 'id');
    }

    public function productSales()
    {
        return $this->hasMany(ProductSale::class, 'sale_id', 'id');
    }
}