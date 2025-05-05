<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;

class Pharmacy extends Model
{
    protected $connection = 'pharmacy_main';
    protected $table = 'pharmacies';
}