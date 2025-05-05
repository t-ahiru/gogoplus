<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;

class ProductBatch extends Model
{
    protected $connection = null; // Dynamic connection
    protected $table = 'product_batches';
}