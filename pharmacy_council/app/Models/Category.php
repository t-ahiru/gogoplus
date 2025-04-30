<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $connection = 'pharmacy_dynamic';
    protected $table = 'categories';

    protected $fillable = ['name', 'image', 'parent_id', 'is_active'];
}