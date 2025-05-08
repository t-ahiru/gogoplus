<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;

class Warehouse extends Model
{
    protected $table = 'warehouses';
    protected $connection = null; // Ensure no hardcoded connection
}