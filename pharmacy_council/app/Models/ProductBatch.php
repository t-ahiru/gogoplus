<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductBatch extends Model
{
    protected $table = 'product_batches';

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', 'id');
    }
}