@extends('layouts.app')

@section('content')
    <div class="container mx-auto px-4 py-6">
        <div class="bg-white rounded-lg shadow-md p-6">
            <h1 class="text-2xl font-semibold text-gray-800 mb-6">Send Data Request to Pharmacy</h1>

            <div class="flex justify-between items-center mb-6">
                <h1 class="text-2xl font-semibold text-gray-800">Data Requests</h1>
                <a href="{{ route('data_requests.index') }}" 
                   class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors flex items-center">
                    <i class="fas fa-list mr-2"></i> View Requests
                </a>
            </div>

            <!-- Flash Messages -->
            @if (session('success'))
                <div class="mb-6 p-4 bg-green-100 border-l-4 border-green-500 text-green-700">
                    <p>{{ session('success') }}</p>
                </div>
            @endif
            @if (session('error'))
                <div class="mb-6 p-4 bg-red-100 border-l-4 border-red-500 text-red-700">
                    <p>{{ session('error') }}</p>
                </div>
            @endif

            <form action="{{ route('data_requests.send') }}" method="POST" class="space-y-6">
                @csrf
                
                <!-- Pharmacy Selection -->
                <div class="space-y-2">
                    <label for="pharmacy_id" class="block text-sm font-medium text-gray-700">Pharmacy</label>
                    <select name="pharmacy_id" id="pharmacy_id" 
                            class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" required>
                        <option value="">Select Pharmacy</option>
                        @foreach ($pharmacies as $pharmacy)
                            <option value="{{ $pharmacy->id }}">{{ $pharmacy->name }}</option>
                        @endforeach
                    </select>
                </div>

                <!-- Request Type -->
                <div class="space-y-2">
                    <label for="request_type" class="block text-sm font-medium text-gray-700">Request Type</label>
                    <input type="text" name="request_type" id="request_type" 
                           class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" 
                           required>
                </div>

                <!-- Details -->
                <div class="space-y-2">
                    <label for="details" class="block text-sm font-medium text-gray-700">Details</label>
                    <textarea name="details" id="details" rows="4"
                              class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                </div>

                <!-- Submit Button -->
                <button type="submit" 
                        class="w-full md:w-auto bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors flex items-center justify-center">
                    <i class="fas fa-paper-plane mr-2"></i> Send Request
                </button>
            </form>
        </div>
    </div>
@endsection