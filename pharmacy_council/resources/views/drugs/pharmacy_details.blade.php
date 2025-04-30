@extends('layouts.app')

@section('content')
    <div class="container mx-auto px-4 py-6">
        <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Product Details</h2>

            <!-- Product Information -->
            <div class="mb-6">
                <h3 class="text-xl font-medium text-gray-700 mb-2">Product: {{ $product->name }}</h3>
                <p class="text-gray-600">Code: {{ $product->code ?? 'N/A' }}</p>
                <p class="text-gray-600">Price: ${{ number_format($product->price, 2) }}</p>
                <p class="text-gray-600">
                    Stock: {{ $product->qty }}
                    @if($product->unit)
                        {{ $product->unit->unit_name }}
                    @endif
                </p>
                @if($product->category)
                    <p class="text-gray-600">Category: {{ $product->category->name }}</p>
                @endif
                @if($product->brand)
                    <p class="text-gray-600">Brand: {{ $product->brand->title }}</p>
                @endif
                @if($product->shelf)
                    <p class="text-gray-600">Shelf: {{ $product->shelf->name }}</p>
                @endif
            </div>

            <!-- Pharmacy Information -->
            <div>
                <h3 class="text-xl font-medium text-gray-700 mb-2">Pharmacy: {{ $pharmacy->name }}</h3>
                <p class="text-gray-600">License No.: {{ $pharmacy->license_number }}</p>
                <p class="text-gray-600">Address: {{ $pharmacy->address }}</p>
                <p class="text-gray-600">Email: {{ $pharmacy->contact_email }}</p>
                <p class="text-gray-600">Phone: {{ $pharmacy->contact_phone }}</p>
            </div>

            <!-- Back Button -->
            <div class="mt-6">
                <a href="{{ route('drug_search.search') }}"
                   class="bg-gray-600 text-white px-4 py-2 rounded-lg hover:bg-gray-700 transition-colors">
                    Back to Search
                </a>
            </div>
        </div>
    </div>
@endsection