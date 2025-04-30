<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Shelf extends Model
{
    protected $connection = 'pharmacy_dynamic';
    protected $table = 'shelves';

    protected $fillable = ['name'];
}