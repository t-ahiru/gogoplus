<?php

namespace App\Http\Controllers;

use App\Models\Pharmacy;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Artisan;

class PharmacyController extends Controller
{
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
        // Switch to the pharmacy's database connection
    config(['database.connections.dynamic' => config("database.connections.{$pharmacy->database_connection}")]);
    DB::purge('dynamic');
    DB::setDefaultConnection('dynamic');

    // Fetch users from the selected pharmacy's database
    $users = DB::table('users')->get();

    // Reset the connection back to default
    DB::setDefaultConnection('pharmacy_main');

    return view('pharmacy-users', compact('pharmacy', 'users'));
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

        // Create a new database for the pharmacy
$dbName = 'pharmacy_' . strtolower(str_replace(' ', '_', $request->name));
DB::statement("CREATE DATABASE IF NOT EXISTS $dbName");

// Add the new database connection dynamically
$connectionName = 'pharmacy_' . (Pharmacy::count() + 1);
config([
    "database.connections.$connectionName" => [
        'driver' => 'mysql',
        'host' => env('DB_HOST', '127.0.0.1'),
        'port' => env('DB_PORT', '3306'),
        'database' => $dbName,
        'username' => env('DB_USERNAME', 'root'),
        'password' => env('DB_PASSWORD', ''),
        'unix_socket' => env('DB_SOCKET', ''),
        'charset' => 'utf8mb4',
        'collation' => 'utf8mb4_unicode_ci',
        'prefix' => '',
        'strict' => true,
        'engine' => 'InnoDB', // Explicitly set engine
    ]
]);

// Run migrations on the new database with proper foreign key handling
config(['database.default' => $connectionName]);

try {
    // Temporarily disable foreign key checks
    DB::statement('SET FOREIGN_KEY_CHECKS=0;');
    
    // Run migrations in correct order - adjust these paths to your actual migration files
    Artisan::call('migrate', [
        '--database' => $connectionName,
        '--path' => [
            'database/migrations/2025_04_03_014118_create_roles_table',
            'database/migrations/0001_01_01_000000_create_users_table',
            'database/migrations/2025_04_03_034523_add_fields_to_users_table',
            'database/migrations/2025_04_12_163639_add_description_to_roles_table'
            // Add other migrations in dependency order
        ],
        '--force' => true
    ]);
} finally {
    // Re-enable foreign key checks
    DB::statement('SET FOREIGN_KEY_CHECKS=1;');
    // Reset the default connection
    config(['database.default' => 'pharmacy_main']);
}

// Save the pharmacy
Pharmacy::create([
    'name' => $request->name,
    'license_number' => $request->license_number,
    'address' => $request->address,
    'location' => $request->location,
    'contact_phone' => $request->contact_phone,
    'contact_email' => $request->contact_email,
    'database_connection' => $connectionName,
]);

return redirect()->route('manage-pharmacy.index')->with('success', 'Pharmacy added successfully.');
    }

    public function trackActivity(Pharmacy $pharmacy, $userId)
    {
        // Switch to the pharmacy's database connection
        config(['database.connections.dynamic' => config("database.connections.{$pharmacy->database_connection}")]);
        DB::purge('dynamic');
        DB::setDefaultConnection('dynamic');

        // Fetch the user and their activities
        $user = DB::table('users')->where('id', $userId)->first();
        $activities = DB::table('activity_logs')->where('user_id', $userId)->get();

        // Reset the connection
        DB::setDefaultConnection('pharmacy_main');

        return view('track-activity', compact('pharmacy', 'user', 'activities'));
    }

    public function show(Pharmacy $pharmacy)
{
    // If you need to switch database for other operations:
    config(['database.connections.dynamic' => config("database.connections.{$pharmacy->database_connection}")]);
    DB::purge('dynamic');
    DB::setDefaultConnection('dynamic');
    
    // Reset the connection back to default
    DB::setDefaultConnection('pharmacy_main');

    return view('pharmacies.show', [
        'pharmacy' => $pharmacy
    ]);
}
}