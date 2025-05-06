<?php

namespace App\Http\Controllers;

use App\Models\Pharmacy;
use App\Services\DatabaseSwitcher;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Artisan;

class PharmacyController extends Controller
{
    protected $databaseSwitcher;

    public function __construct(DatabaseSwitcher $databaseSwitcher)
    {
        $this->databaseSwitcher = $databaseSwitcher;
    }

    public function index(Request $request)
    {
        $search = $request->input('search');
        
        $pharmacies = Pharmacy::when($search, function ($query, $search) {
                return $query->where('name', 'like', '%'.$search.'%')
                            ->orWhere('location', 'like', '%'.$search.'%')
                            ->orWhere('license_number', 'like', '%'.$search.'%');
            })
            ->orderBy('name')
            ->paginate(5);

        return view('manage-pharmacy', compact('pharmacies'));
    }

    public function manageUsers(Pharmacy $pharmacy)
    {
        try {
            // Switch to pharmacy database
            $this->databaseSwitcher->switchToPharmacy($pharmacy->id);

            // Fetch users from the pharmacy's database
            $users = DB::connection('pharmacy_dynamic')->table('users')->get();

            return view('pharmacy-users', compact('pharmacy', 'users'));
        } finally {
            // Always switch back to main database
            $this->databaseSwitcher->switchToMain();
        }
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|unique:pharmacies,name',
            'license_number' => 'required|string|unique:pharmacies,license_number',
            'address' => 'required|string',
            'location' => 'required|string',
            'contact_phone' => 'required|string',
            'contact_email' => 'required|email|unique:pharmacies,contact_email',
        ]);

        // Create a new pharmacy record first to get the ID
        $pharmacy = Pharmacy::create([
            'name' => $request->name,
            'license_number' => $request->license_number,
            'address' => $request->address,
            'location' => $request->location,
            'contact_phone' => $request->contact_phone,
            'contact_email' => $request->contact_email,
            'database_connection' => 'pharmacy_dynamic', // Store dynamic connection name
        ]);

        // Create database with ID-based name
        $dbName = 'pharmacy' . $pharmacy->id;
        DB::statement("CREATE DATABASE IF NOT EXISTS $dbName");

        try {
            // Switch to the new pharmacy database
            $this->databaseSwitcher->switchToPharmacy($pharmacy->id);

            // Run migrations with proper foreign key handling
            DB::statement('SET FOREIGN_KEY_CHECKS=0;');
            
            Artisan::call('migrate', [
                '--database' => 'pharmacy_dynamic',
                '--path' => [
                    'database/migrations/2025_04_03_014118_create_roles_table',
                    'database/migrations/0001_01_01_000000_create_users_table',
                    'database/migrations/2025_04_03_034523_add_fields_to_users_table',
                    'database/migrations/2025_04_12_163639_add_description_to_roles_table'
                ],
                '--force' => true
            ]);
        } finally {
            // Re-enable foreign key checks and switch back
            DB::statement('SET FOREIGN_KEY_CHECKS=1;');
            $this->databaseSwitcher->switchToMain();
        }

        return redirect()->route('manage-pharmacy.index')->with('success', 'Pharmacy added successfully.');
    }

    public function trackActivity(Pharmacy $pharmacy, $userId)
    {
        try {
            // Switch to pharmacy database
            $this->databaseSwitcher->switchToPharmacy($pharmacy->id);

            // Fetch user and activities
            $user = DB::connection('pharmacy_dynamic')->table('users')->where('id', $userId)->first();
            $activities = DB::connection('pharmacy_dynamic')->table('activity_logs')->where('user_id', $userId)->get();

            return view('track-activity', compact('pharmacy', 'user', 'activities'));
        } finally {
            // Always switch back to main database
            $this->databaseSwitcher->switchToMain();
        }
    }

    public function show(Pharmacy $pharmacy)
    {
        try {
            // Switch to pharmacy database if needed
            $this->databaseSwitcher->switchToPharmacy($pharmacy->id);
            
            // Add any specific pharmacy database queries here if needed
            
            return view('pharmacies.show', [
                'pharmacy' => $pharmacy
            ]);
        } finally {
            // Always switch back to main database
            $this->databaseSwitcher->switchToMain();
        }
    }
}