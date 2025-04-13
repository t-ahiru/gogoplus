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
            'database_connection',
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