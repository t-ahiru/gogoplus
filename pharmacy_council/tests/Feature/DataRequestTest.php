<?php

namespace Tests\Feature;

use App\Models\Pharmacy;
use App\Models\DataRequest;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Http;
use Tests\TestCase;

class DataRequestTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Test sending a data request to a pharmacy with a configured API.
     */
    public function test_send_request_to_pharmacy_api_success()
    {
        // Arrange: Create a pharmacy with API details
        $pharmacy = Pharmacy::create([
            'name' => 'Test Pharmacy',
            'license_number' => 'PH123',
            'address' => '123 Main St',
            'location' => 'New York',
            'contact_phone' => '555-1234',
            'contact_email' => 'test@pharmacy.com',
            'database_connection' => null,
            'api_endpoint' => 'https://api.pharmacy.com/data',
            'api_key' => 'test-key',
            'api_status' => 'unknown',
        ]);

        // Fake the HTTP response
        Http::fake([
            'https://api.pharmacy.com/data' => Http::response(['data' => 'success'], 200),
        ]);

        // Act: Send a POST request to the sendRequest endpoint
        $response = $this->post(route('data_requests.send'), [
            'pharmacy_id' => $pharmacy->id,
            'request_type' => 'sales_data',
            'details' => 'Monthly sales report',
        ]);

        // Assert: Check the response and database
        $response->assertRedirect();
        $response->assertSessionHas('success', 'Request sent and response received.');

        $this->assertDatabaseHas('data_requests', [
            'pharmacy_id' => $pharmacy->id,
            'request_type' => 'sales_data',
            'details' => 'Monthly sales report',
            'status' => 'completed',
        ]);

        $this->assertDatabaseHas('pharmacies', [
            'id' => $pharmacy->id,
            'api_status' => 'active',
        ]);

        $this->assertNotNull($pharmacy->fresh()->last_api_request_at);
    }

    /**
     * Test sending a data request to a pharmacy with a failing API.
     */
    public function test_send_request_to_pharmacy_api_failure()
    {
        // Arrange: Create a pharmacy with API details
        $pharmacy = Pharmacy::create([
            'name' => 'Test Pharmacy',
            'license_number' => 'PH123',
            'address' => '123 Main St',
            'location' => 'New York',
            'contact_phone' => '555-1234',
            'contact_email' => 'test@pharmacy.com',
            'database_connection' => null,
            'api_endpoint' => 'https://api.pharmacy.com/data',
            'api_key' => 'test-key',
            'api_status' => 'unknown',
        ]);

        // Fake a failed HTTP response
        Http::fake([
            'https://api.pharmacy.com/data' => Http::response(['error' => 'Server error'], 500),
        ]);

        // Act: Send a POST request to the sendRequest endpoint
        $response = $this->post(route('data_requests.send'), [
            'pharmacy_id' => $pharmacy->id,
            'request_type' => 'sales_data',
            'details' => 'Monthly sales report',
        ]);

        // Assert: Check the response and database
        $response->assertRedirect();
        $response->assertSessionHas('error', 'Failed to get response from pharmacy API.');

        $this->assertDatabaseHas('data_requests', [
            'pharmacy_id' => $pharmacy->id,
            'request_type' => 'sales_data',
            'details' => 'Monthly sales report',
            'status' => 'failed',
        ]);

        $this->assertDatabaseHas('pharmacies', [
            'id' => $pharmacy->id,
            'api_status' => 'inactive',
        ]);

        $this->assertNotNull($pharmacy->fresh()->last_api_request_at);
    }

    /**
     * Test sending a data request to a pharmacy without a configured API.
     */
    public function test_send_request_to_pharmacy_without_api_configured()
    {
        // Arrange: Create a pharmacy without API details
        $pharmacy = Pharmacy::create([
            'name' => 'Test Pharmacy',
            'license_number' => 'PH123',
            'address' => '123 Main St',
            'location' => 'New York',
            'contact_phone' => '555-1234',
            'contact_email' => 'test@pharmacy.com',
            'database_connection' => null,
            'api_endpoint' => null,
            'api_key' => null,
            'api_status' => 'unknown',
        ]);

        // Act: Send a POST request to the sendRequest endpoint
        $response = $this->post(route('data_requests.send'), [
            'pharmacy_id' => $pharmacy->id,
            'request_type' => 'sales_data',
            'details' => 'Monthly sales report',
        ]);

        // Assert: Check the response and database
        $response->assertRedirect();
        $response->assertSessionHas('error', 'Pharmacy API endpoint or key not configured.');

        // No data request should be created
        $this->assertDatabaseMissing('data_requests', [
            'pharmacy_id' => $pharmacy->id,
        ]);

        $this->assertDatabaseHas('pharmacies', [
            'id' => $pharmacy->id,
            'api_status' => 'unknown',
            'last_api_request_at' => null,
        ]);
    }
}