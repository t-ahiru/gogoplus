<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $connection = null; // Dynamic connection
    protected $table = 'products';
}