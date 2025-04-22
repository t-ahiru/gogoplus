<?php

namespace Database\Seeders;

use App\Models\Pharmacy;
use Illuminate\Database\Seeder;

class PharmacySeeder extends Seeder
{
    public function run()
    {
        // Optionally truncate the table if you want to start fresh
        // Pharmacy::truncate();

        $pharmacies = [
            [
                'name' => 'Pharmacy 1',
                'license_number' => 'LIC001',
                'address' => '123 Main St, City A',
                'location' => 'City A',
                'contact_phone' => '123-456-7890',
                'contact_email' => 'pharmacy1@example.com',
                'database_connection' => 'pharmacy1',
                'api_endpoint' => 'https://pharmacy1-api.free.beeceptor.com/data',
                'api_key' => 'test-key-1',
                'api_status' => 'unknown',
                'last_api_request_at' => null,
            ],
            [
                'name' => 'Pharmacy 2',
                'license_number' => 'LIC002',
                'address' => '456 Oak St, City B',
                'location' => 'City B',
                'contact_phone' => '234-567-8901',
                'contact_email' => 'pharmacy2@example.com',
                'database_connection' => 'pharmacy2',
                'api_endpoint' => 'https://pharmacy2-api.free.beeceptor.com/data',
                'api_key' => 'test-key-2',
                'api_status' => 'unknown',
                'last_api_request_at' => null,
            ],
            [
                'name' => 'Pharmacy 3',
                'license_number' => 'LIC003',
                'address' => '789 Pine St, City C',
                'location' => 'City C',
                'contact_phone' => '345-678-9012',
                'contact_email' => 'pharmacy3@example.com',
                'database_connection' => 'pharmacy3',
                'api_endpoint' => null, // No API configured for testing failure cases
                'api_key' => null,
                'api_status' => 'unknown',
                'last_api_request_at' => null,
            ],
            [
                'name' => 'Pharmacy 4',
                'license_number' => 'LIC004',
                'address' => '101 Maple St, City D',
                'location' => 'City D',
                'contact_phone' => '456-789-0123',
                'contact_email' => 'pharmacy4@example.com',
                'database_connection' => 'pharmacy4',
                'api_endpoint' => 'https://pharmacy4-api.free.beeceptor.com/data',
                'api_key' => 'test-key-4',
                'api_status' => 'unknown',
                'last_api_request_at' => null,
            ],
            [
                'name' => 'Pharmacy 5',
                'license_number' => 'LIC005',
                'address' => '202 Birch St, City E',
                'location' => 'City E',
                'contact_phone' => '567-890-1234',
                'contact_email' => 'pharmacy5@example.com',
                'database_connection' => 'pharmacy5',
                'api_endpoint' => 'https://pharmacy5-api.free.beeceptor.com/data',
                'api_key' => 'test-key-5',
                'api_status' => 'unknown',
                'last_api_request_at' => null,
            ],
        ];

        foreach ($pharmacies as $pharmacy) {
            Pharmacy::updateOrCreate(
                ['database_connection' => $pharmacy['database_connection']],
                $pharmacy
            );
        }
    }
}