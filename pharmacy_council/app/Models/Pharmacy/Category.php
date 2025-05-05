<?php
// app/Models/Pharmacy/Category.php
namespace App\Models\Pharmacy;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $connection = 'posintern';
    protected $table = 'categories';
    
    protected $fillable = [
        'name', 'image', 'parent_id', 'is_active'
    ];
}