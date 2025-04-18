<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Drug extends Model
{
    protected $connection = 'pharmacy_main';
    protected $table = 'drugs';
    protected $fillable = ['drug_code', 'name', 'generic_name', 'category_id', 'brand_id', 'description', 'is_active'];

    public function availability()
{
    return $this->hasMany(DrugPharmacyAvailability::class, 'drug_code', 'drug_code');
}
}
