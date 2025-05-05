<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;

class Warehouse extends Model
{
    protected $connection = 'dynamic_connection'; // Matches the pharmacy database connection
    protected $table = 'warehouses';
}