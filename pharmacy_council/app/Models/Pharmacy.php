<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pharmacy extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'license_number',
        'address',
        'location',
        'contact_phone',
        'contact_email',
        'owner_name',
        'registration_date',
        'status', // e.g., 'active', 'suspended', 'inactive'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array
     */
    protected $casts = [
        'registration_date' => 'date',
    ];

    /**
     * Get the users associated with this pharmacy.
     */
    public function users()
    {
        return $this->hasMany(User::class);
    }

    /**
     * Get the inventory items for this pharmacy.
     */
    public function inventoryItems()
    {
        return $this->hasMany(InventoryItem::class);
    }

    /**
     * Get the orders for this pharmacy.
     */
    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    /**
     * Get the activities/logs for this pharmacy.
     */
    public function activities()
    {
        return $this->hasMany(ActivityLog::class);
    }

    /**
     * Scope a query to only include active pharmacies.
     */
    public function scopeActive($query)
    {
        return $query->where('status', 'active');
    }

    /**
     * Get the pharmacy's full address with location.
     */
    public function getFullAddressAttribute()
    {
        return "{$this->address}, {$this->location}";
    }

    /**
     * Get the pharmacy's contact information.
     */
    public function getContactInfoAttribute()
    {
        return "Phone: {$this->contact_phone}, Email: {$this->contact_email}";
    }
}