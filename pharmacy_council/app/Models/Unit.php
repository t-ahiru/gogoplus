<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Unit extends Model
{
    protected $connection = 'pharmacy_dynamic';
    protected $table = 'units';

    protected $fillable = ['unit_code', 'unit_name', 'base_unit', 'operator', 'operation_value', 'is_active'];
}