<?php
// app/Models/Pharmacy/Warehouse.php
namespace App\Models\Pharmacy;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Warehouse extends Model
{
    protected $connection = 'posintern';
    protected $table = 'warehouses';
    
    protected $fillable = [
        'name', 'phone', 'email', 'address'
    ];
    
    public function sales(): HasMany
    {
        return $this->hasMany(Sale::class);
    }
}