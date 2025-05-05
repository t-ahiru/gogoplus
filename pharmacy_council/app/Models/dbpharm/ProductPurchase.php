<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;

class ProductPurchase extends Model
{
    protected $connection = 'dynamic_connection';
    protected $table = 'product_purchases';

    public function purchase()
    {
        return $this->belongsTo(Purchase::class, 'purchase_id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }
}