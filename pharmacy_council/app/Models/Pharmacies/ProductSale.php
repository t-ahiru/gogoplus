<?php
// app/Models/Pharmacy/ProductSale.php
namespace App\Models\Pharmacy;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProductSale extends Model
{
    protected $connection = 'posintern';
    protected $table = 'product_sales';
    
    protected $fillable = [
        'sale_id', 'product_id', 'product_batch_id', 'qty', 'net_unit_price', 'total'
    ];
    
    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }
    
    public function batch(): BelongsTo
    {
        return $this->belongsTo(ProductBatch::class, 'product_batch_id');
    }
}