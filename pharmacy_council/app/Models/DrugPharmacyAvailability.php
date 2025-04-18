<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DrugPharmacyAvailability extends Model
{
    protected $connection = 'pharmacy_main';
    protected $table = 'drug_pharmacy_availability';
    protected $primaryKey = 'id';
    protected $fillable = ['drug_code', 'pharmacy_id', 'stock_quantity', 'last_updated'];

    protected $casts = [
        'last_updated' => 'datetime',
    ];
}