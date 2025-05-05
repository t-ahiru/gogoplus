<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;

class ProductSale extends Model
{
    protected $connection = null;
    protected $table = 'product_sales';

    // Map qty to quantity
    protected $appends = ['quantity'];

    public function getQuantityAttribute()
    {
        return $this->qty;
    }

    public function sale()
    {
        return $this->belongsTo(Sale::class, 'sale_id', 'id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', 'id');
    }

    public function productBatch()
    {
        return $this->belongsTo(ProductBatch::class, 'product_batch_id', 'id');
    }
}