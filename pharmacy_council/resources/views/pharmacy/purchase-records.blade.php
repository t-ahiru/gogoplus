@extends('layouts.app')

@section('content')
<div class="container mx-auto px-4 py-6">
    <h1 class="text-2xl font-bold mb-6 text-gray-800">Pharmacy Purchase Records</h1>

    <!-- Filters Form -->
    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
        <h2 class="text-xl font-semibold mb-4 text-gray-700">Filters</h2>
        <form method="GET" action="{{ route('pharmacy.purchase-records') }}" class="grid grid-cols-1 md:grid-cols-6 gap-4">
            <!-- Pharmacy Filter -->
            <div>
                <label for="pharmacy" class="block text-sm font-medium text-gray-700">Pharmacy</label>
                <select name="pharmacy" id="pharmacy" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    <option value="">All Pharmacies</option>
                    @foreach($pharmacies as $pharmacy)
                        <option value="{{ $pharmacy->database_connection }}" {{ request('pharmacy') == $pharmacy->database_connection ? 'selected' : '' }}>
                            {{ $pharmacy->name }}
                        </option>
                    @endforeach
                </select>
            </div>

            <!-- Warehouse Filter -->
            <div>
                <label for="warehouse" class="block text-sm font-medium text-gray-700">Warehouse</label>
                <select name="warehouse" id="warehouse" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    <option value="">All Warehouses</option>
                    <!-- Options will be populated dynamically via JavaScript -->
                </select>
            </div>

            <!-- Drug Filter -->
            <div>
                <label for="drug" class="block text-sm font-medium text-gray-700">Drug</label>
                <select name="drug" id="drug" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    <option value="">All Drugs</option>
                    @foreach($drugs as $drug)
                        <option value="{{ $drug->id }}" {{ request('drug') == $drug->id ? 'selected' : '' }}>
                            {{ $drug->name }}
                        </option>
                    @endforeach
                </select>
            </div>

            <!-- Customer Filter -->
            <div>
                <label for="customer" class="block text-sm font-medium text-gray-700">Customer</label>
                <select name="customer" id="customer" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    <option value="">All Customers</option>
                    @foreach($customers as $customer)
                        <option value="{{ $customer->id }}" {{ request('customer') == $customer->id ? 'selected' : '' }}>
                            {{ $customer->name }}
                        </option>
                    @endforeach
                </select>
            </div>

            <!-- Date Filter -->
            <div>
                <label for="date" class="block text-sm font-medium text-gray-700">Date</label>
                <input type="text" name="date" id="date" value="{{ request('date') }}" placeholder="Select Date" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
            </div>

            <!-- Filter and Reset Buttons -->
            <div class="flex items-end space-x-2">
                <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">Filter</button>
                <a href="{{ route('pharmacy.purchase-records') }}" class="bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400">Reset</a>
            </div>
        </form>
    </div>

    <!-- Purchase Records -->
    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
        <h2 class="text-xl font-semibold mb-4 text-gray-700">Purchase Records</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white">
                <thead>
                    <tr class="bg-gray-100">
                        <th class="py-2 px-4 border">Date</th>
                        <th class="py-2 px-4 border">Supplier</th>
                        <th class="py-2 px-4 border">Drug</th>
                        <th class="py-2 px-4 border">Quantity</th>
                        <th class="py-2 px-4 border">Received Quantity</th>
                        <th class="py-2 px-4 border">Return Quantity</th>
                        <th class="py-2 px-4 border">Net Unit Cost</th>
                        <th class="py-2 px-4 border">Total</th>
                        <th class="py-2 px-4 border">Pharmacy</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($purchaseRecords as $record)
                    <tr class="hover:bg-gray-50">
                        <td class="py-2 px-4 border">{{ $record->created_at->format('d/m/Y H:i') }}</td>
                        <td class="py-2 px-4 border">{{ $record->purchase->customer->name ?? 'N/A' }}</td>
                        <td class="py-2 px-4 border">{{ $record->product->name ?? 'N/A' }}</td>
                        <td class="py-2 px-4 border">{{ $record->qty }}</td>
                        <td class="py-2 px-4 border">{{ $record->received_qty }}</td>
                        <td class="py-2 px-4 border">{{ $record->return_qty }}</td>
                        <td class="py-2 px-4 border">{{ $record->net_unit_cost }}</td>
                        <td class="py-2 px-4 border">{{ $record->total }}</td>
                        <td class="py-2 px-4 border">{{ $record->pharmacy_name }}</td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
            <div class="mt-4">
                {{ $purchaseRecords->links() }}
            </div>
        </div>
    </div>
</div>

<!-- Include Flatpickr for Date Picker -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    // Pass warehouses data to JavaScript
    const warehouses = @json($warehouses);

    document.addEventListener('DOMContentLoaded', function () {
        // Initialize Flatpickr
        flatpickr("#date", {
            mode: "range",
            dateFormat: "Y-m-d",
            defaultDate: "{{ request('date') ?: now()->startOfMonth()->format('Y-m-d') . ' to ' . now()->endOfMonth()->format('Y-m-d') }}"
        });

        // Get DOM elements
        const pharmacySelect = document.getElementById('pharmacy');
        const warehouseSelect = document.getElementById('warehouse');

        // Function to update warehouse options based on selected pharmacy
        function updateWarehouses() {
            const selectedPharmacy = pharmacySelect.value;

            // Clear existing options
            warehouseSelect.innerHTML = '<option value="">All Warehouses</option>';

            if (selectedPharmacy && warehouses[selectedPharmacy]) {
                warehouses[selectedPharmacy].forEach(warehouse => {
                    const option = document.createElement('option');
                    option.value = warehouse.id;
                    option.textContent = warehouse.name;
                    if ("{{ request('warehouse') }}" == warehouse.id) {
                        option.selected = true;
                    }
                    warehouseSelect.appendChild(option);
                });
            }
        }

        // Initial update of warehouses
        updateWarehouses();

        // Update warehouses when pharmacy selection changes
        pharmacySelect.addEventListener('change', updateWarehouses);
    });
</script>
@endsection