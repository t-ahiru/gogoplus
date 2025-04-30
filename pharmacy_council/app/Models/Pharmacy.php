<?php

namespace App\Models;

use App\Services\DatabaseSwitcher;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

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
        'api_endpoint',
        'api_key',
        'api_status',
        'last_api_request_at',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array
     */
    protected $casts = [
        'registration_date' => 'date',
        'last_api_request_at' => 'datetime',
    ];

    /**
     * Get the users associated with this pharmacy.
     */
    public function users()
    {
        // Dynamically switch to the pharmacy database
        $databaseSwitcher = app(DatabaseSwitcher::class);
        $databaseSwitcher->switchToPharmacy($this->id);

        try {
            // Query users from the pharmacy-specific database
            $users = User::on('pharmacy_dynamic')->get();
            return $users;
        } finally {
            // Always switch back to the main database
            $databaseSwitcher->switchToMain();
        }
    }

    /**
     * Get the data requests associated with this pharmacy.
     */
    public function dataRequests()
    {
        return $this->hasMany(DataRequest::class);
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

    /**
     * Check if the pharmacy has a configured API.
     *
     * @return bool
     */
    public function hasApiConfigured(): bool
    {
        return !empty($this->api_endpoint) && !empty($this->api_key);
    }

    /**
     * Scope a query to only include pharmacies with active APIs.
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $query
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeWithActiveApi($query)
    {
        return $query->where('api_status', 'active');
    }

    /**
     * Get the database name for this pharmacy.
     *
     * @return string
     */
    public function getDatabaseNameAttribute(): string
    {
        return 'pharmacy' . $this->id;
    }

    public function getAuthPassword()
    {
          return $this->api_key;
    }
}