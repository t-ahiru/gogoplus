<?php
// app/Models/Pharmacy/Brand.php
namespace App\Models\Pharmacy;

use Illuminate\Database\Eloquent\Model;

class Brand extends Model
{
    protected $connection = 'posintern';
    protected $table = 'brands';
    
    protected $fillable = [
        'title', 'image', 'is_active'
    ];
}