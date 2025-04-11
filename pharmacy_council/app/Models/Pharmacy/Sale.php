<?php
// app/Models/Pharmacy/Sale.php
namespace App\Models\Pharmacy;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Sale extends Model
{
    protected $connection = 'posintern';
    protected $table = 'sales';
    
    protected $fillable = [
        'reference_no', 'user_id', 'customer_id', 'warehouse_id', 'biller_id',
        'item', 'total_qty', 'total_price', 'grand_total', 'sale_status', 'payment_status'
    ];
    
    public function products(): HasMany
    {
        return $this->hasMany(ProductSale::class, 'sale_id');
    }
    
    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class);
    }
    
    public function warehouse(): BelongsTo
    {
        return $this->belongsTo(Warehouse::class);
    }
    
   
}