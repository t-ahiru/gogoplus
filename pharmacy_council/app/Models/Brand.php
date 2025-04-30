<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Brand extends Model
{
    protected $connection = 'pharmacy_dynamic';
    protected $table = 'brands';

    protected $fillable = ['title', 'image', 'is_active'];
}