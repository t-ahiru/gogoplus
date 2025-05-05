@extends('layouts.app')

@section('content')
<div class="container mx-auto px-4 py-6">
    <h1 class="text-2xl font-bold mb-6 text-gray-800">Pharmacy Records</h1>

    <!-- Create Form -->
    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
        <h2 class="text-xl font-semibold mb-4 text-gray-700">Create Record</h2>
        <form method="POST" action="{{ route('records.store') }}">
            @csrf
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label for="patient_name" class="block text-sm font-medium text-gray-700">Patient Name</label>
                    <input type="text" name="patient_name" id="patient_name" value="John Doe" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                </div>
                <div>
                    <label for="medication" class="block text-sm font-medium text-gray-700">Medication</label>
                    <input type="text" name="medication" id="medication" value="Aspirin" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                </div>
                <div>
                    <label for="pharmacy_id" class="block text-sm font-medium text-gray-700">Pharmacy</label>
                    <select name="pharmacy_id" id="pharmacy_id" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                        <option value="1">Pharmacy 1</option>
                        <option value="2">Pharmacy 2</option>
                        <option value="3">Pharmacy 3</option>
                        <option value="4">Pharmacy 4</option>
                        <option value="5">Pharmacy 5</option>
                    </select>
                </div>
                <div>
                    <label for="warehouse_id" class="block text-sm font-medium text-gray-700">Warehouse</label>
                    <select name="warehouse_id" id="warehouse_id" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                        <option value="1">Warehouse 1</option>
                        <option value="2">Warehouse 2</option>
                        <option value="3">Warehouse 3</option>
                    </select>
                </div>
            </div>
            <button type="submit" class="mt-4 bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">Create</button>
        </form>
    </div>
</div>
@endsection