<?php
// app/Models/Pharmacy/Product.php
namespace App\Models\Pharmacy;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Product extends Model
{
    protected $connection = 'posintern';
    protected $table = 'products';
    
    protected $fillable = [
        'name', 'code', 'type', 'brand_id', 'category_id', 'price', 'qty'
    ];
    
    public function brand(): BelongsTo
    {
        return $this->belongsTo(Brand::class);
    }
    
    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }
}