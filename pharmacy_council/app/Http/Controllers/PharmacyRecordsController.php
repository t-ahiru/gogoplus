<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\dbpharm\ProductSale;
use App\Models\dbpharm\Sale;
use App\Models\dbpharm\Product;
use App\Models\dbpharm\Customer;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Events\ActivityLogged;

class PharmacyRecordsController extends Controller
{
    public function index(Request $request)
    {
        // Log the view_records action
        $selectedPharmacy = $request->input('pharmacy');
        $pharmacyId = $selectedPharmacy ? DB::connection('pharmacy_main')
            ->table('pharmacies')
            ->where('database_connection', $selectedPharmacy)
            ->value('id') : null;

        event(new ActivityLogged(
            auth()->id(),
            'view_records',
            null,
            null,
            json_encode(['filters' => $request->all()]),
            $request->path(),
            $pharmacyId
        ));

        // Fetch pharmacies for the dropdown
        $pharmacies = DB::connection('pharmacy_main')
            ->table('pharmacies')
            ->select('id', 'name', 'database_connection')
            ->get()
            ->keyBy('database_connection');

        // Fetch warehouses for the dropdown (aggregate from all selected pharmacies)
        $warehouses = collect();
        $connections = $selectedPharmacy ? [$selectedPharmacy] : array_column($pharmacies->toArray(), 'database_connection');
        foreach ($connections as $connection) {
            try {
                $pharmacyWarehouses = DB::connection($connection)
                    ->table('warehouses')
                    ->select('id', 'name')
                    ->get()
                    ->map(function ($warehouse) use ($connection) {
                        $warehouse->database_connection = $connection;
                        return $warehouse;
                    });
                $warehouses = $warehouses->merge($pharmacyWarehouses);
            } catch (\Exception $e) {
                \Log::error("Failed to fetch warehouses from {$connection}: " . $e->getMessage());
            }
        }
        $warehouses = $warehouses->groupBy('database_connection');

        // Fetch drugs for the dropdown (aggregate from all pharmacies)
        $drugs = collect();
        foreach ($pharmacies as $pharmacy) {
            try {
                $pharmacyDrugs = Product::on($pharmacy->database_connection)
                    ->select('id', 'name')
                    ->get();
                $drugs = $drugs->merge($pharmacyDrugs);
            } catch (\Exception $e) {
                \Log::error("Failed to fetch drugs from {$pharmacy->database_connection}: " . $e->getMessage());
            }
        }
        $drugs = $drugs->unique('id')->sortBy('name');

        // Fetch customers for the dropdown (aggregate from all pharmacies)
        $customers = collect();
        foreach ($pharmacies as $pharmacy) {
            try {
                $pharmacyCustomers = Customer::on($pharmacy->database_connection)
                    ->select('id', 'name')
                    ->get();
                $customers = $customers->merge($pharmacyCustomers);
            } catch (\Exception $e) {
                \Log::error("Failed to fetch customers from {$pharmacy->database_connection}: " . $e->getMessage());
            }
        }
        $customers = $customers->unique('id')->sortBy('name');

        // Get filter inputs
        $selectedPharmacy = $request->input('pharmacy');
        $selectedDrug = $request->input('drug');
        $selectedCustomer = $request->input('customer');
        $selectedWarehouse = $request->input('warehouse');
        $dateRange = $request->input('date');

        // Parse date range or default to current month
        if ($dateRange) {
            $dates = explode(' to ', $dateRange);
            $startDate = Carbon::parse($dates[0])->startOfDay();
            $endDate = isset($dates[1]) ? Carbon::parse($dates[1])->endOfDay() : $startDate->copy()->endOfDay();
        } else {
            $startDate = now()->startOfMonth();
            $endDate = now()->endOfMonth();
        }

        // Determine which connections to query
        $connections = $selectedPharmacy ? [$selectedPharmacy] : array_column($pharmacies->toArray(), 'database_connection');

        $dispensingRecords = collect();
        $prescriptions = collect();

        // Aggregate dispensing records with filters
        foreach ($connections as $connection) {
            try {
                $query = ProductSale::on($connection)
                    ->with(['sale.customer', 'product', 'productBatch'])
                    ->orderBy('created_at', 'desc');

                if ($selectedDrug) {
                    $query->where('product_id', $selectedDrug);
                }
                if ($selectedCustomer) {
                    $query->whereHas('sale', function ($q) use ($selectedCustomer) {
                        $q->where('customer_id', $selectedCustomer);
                    });
                }
                if ($selectedWarehouse) {
                    $query->where('warehouse_id', $selectedWarehouse);
                }
                $query->whereBetween('created_at', [$startDate, $endDate]);

                $records = $query->get()
                    ->map(function ($record) use ($connection, $pharmacies) {
                        $record->pharmacy_name = $pharmacies[$connection]->name;
                        $record->pharmacy_id = $pharmacies[$connection]->id;
                        return $record;
                    });

                $dispensingRecords = $dispensingRecords->merge($records);
            } catch (\Exception $e) {
                \Log::error("Failed to fetch dispensing records from $connection: " . $e->getMessage());
            }
        }

        // Aggregate prescriptions with filters
        foreach ($connections as $connection) {
            try {
                $query = Sale::on($connection)
                    ->with(['customer', 'user'])
                    ->whereNotNull('sale_note')
                    ->orderBy('created_at', 'desc');

                if ($selectedCustomer) {
                    $query->where('customer_id', $selectedCustomer);
                }
                if ($selectedWarehouse) {
                    $query->where('warehouse_id', $selectedWarehouse);
                }
                $query->whereBetween('created_at', [$startDate, $endDate]);

                $records = $query->get()
                    ->map(function ($record) use ($connection, $pharmacies) {
                        $record->pharmacy_name = $pharmacies[$connection]->name;
                        $record->pharmacy_id = $pharmacies[$connection]->id;
                        return $record;
                    });

                $prescriptions = $prescriptions->merge($records);
            } catch (\Exception $e) {
                \Log::error("Failed to fetch prescriptions from $connection: " . $e->getMessage());
            }
        }

        // Paginate dispensing records
        $perPage = 20;
        $dispensingRecords = $dispensingRecords->sortByDesc('created_at');
        $currentPageDispensing = request()->query('dispensing_page', 1);
        $dispensingRecords = new LengthAwarePaginator(
            $dispensingRecords->forPage($currentPageDispensing, $perPage),
            $dispensingRecords->count(),
            $perPage,
            $currentPageDispensing,
            ['path' => route('pharmacy.records'), 'pageName' => 'dispensing_page']
        );

        // Paginate prescriptions
        $prescriptions = $prescriptions->sortByDesc('created_at');
        $currentPagePrescriptions = request()->query('prescription_page', 1);
        $prescriptions = new LengthAwarePaginator(
            $prescriptions->forPage($currentPagePrescriptions, $perPage),
            $prescriptions->count(),
            $perPage,
            $currentPagePrescriptions,
            ['path' => route('pharmacy.records'), 'pageName' => 'prescription_page']
        );

        return view('pharmacy.records', compact('dispensingRecords', 'prescriptions', 'pharmacies', 'drugs', 'customers', 'warehouses'))
            ->with('header', 'Pharmacy Records');
    }
}