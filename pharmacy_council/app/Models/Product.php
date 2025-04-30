<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $connection = 'pharmacy_dynamic';
    protected $table = 'products';

    protected $fillable = [
        'name',
        'code',
        'barcode_symbology',
        'category_id',
        'unit_id',
        'cost',
        'price',
        'qty',
        'alert_quantity',
        'tax_id',
        'tax_method',
        'note',
        'product_details',
        'warehouse_id',
        'is_active',
        'brand_id',
        'promotion',
        'promo_price',
        'starting_date',
        'last_date',
        'is_batch',
        'variant_id',
        'is_variant',
        'featured',
        'is_prescribe',
        'is_prescribe_qty',
        'product_list',
        'variant_list',
        'weight',
        'shelf_id',
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'price' => 'decimal:2',
        'promo_price' => 'decimal:2',
        'cost' => 'decimal:2',
        'qty' => 'decimal:2',
        'alert_quantity' => 'decimal:2',
        'weight' => 'decimal:2',
    ];

    /**
     * Scope a query to only include available products (qty > 0).
     */
    public function scopeAvailable($query)
    {
        return $query->where('qty', '>', 0);
    }

    /**
     * Get the category associated with the product.
     */
    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }

    /**
     * Get the brand associated with the product.
     */
    public function brand()
    {
        return $this->belongsTo(Brand::class, 'brand_id');
    }

    /**
     * Get the shelf associated with the product.
     */
    public function shelf()
    {
        return $this->belongsTo(Shelf::class, 'shelf_id');
    }

    /**
     * Get the unit associated with the product.
     */
    public function unit()
    {
        return $this->belongsTo(Unit::class, 'unit_id');
    }
}