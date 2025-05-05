<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    protected $connection = null; // Dynamic connection
    protected $table = 'customers';
}