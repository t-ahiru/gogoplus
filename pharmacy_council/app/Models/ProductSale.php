<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductSale extends Model
{
    protected $table = 'sales';
    protected $primaryKey = 'id';
    public $timestamps = true;

    public function productSales()
    {
        return $this->hasMany(ProductSale::class, 'sale_id');
    }
}