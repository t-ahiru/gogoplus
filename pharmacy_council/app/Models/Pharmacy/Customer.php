<?php
// app/Models/Pharmacy/Customer.php
namespace App\Models\Pharmacy;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Customer extends Model
{
    protected $connection = 'posintern';
    protected $table = 'customers';
    
    protected $fillable = [
        'name', 'company_name', 'email', 'phone_number', 'address', 'city'
    ];
    
    public function sales(): HasMany
    {
        return $this->hasMany(Sale::class);
    }
}