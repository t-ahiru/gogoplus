@extends('layouts.app')

@section('content')
<div class="py-6">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <!-- Header Section -->
        <div class="mb-8">
            <h2 class="text-2xl font-bold text-gray-800">
                <i class="fas fa-clinic-medical text-blue-500 mr-2"></i>Pharmacy Management
            </h2>
            <p class="mt-1 text-sm text-gray-600">Select or register pharmacies to manage their activities</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <!-- Registered Pharmacies Card -->
            <div class="bg-white shadow rounded-lg">
                <div class="px-4 py-4 bg-gray-800 rounded-t-lg">
                    <h3 class="text-lg font-medium text-white">
                        <i class="fas fa-store-alt mr-2"></i>Registered Pharmacies
                    </h3>
                </div>
                <div class="p-4">
                    @if ($pharmacies->isEmpty())
                        <div class="text-center py-4">
                            <i class="fas fa-info-circle text-blue-400 text-4xl mb-2"></i>
                            <p class="text-gray-500">No pharmacies registered yet.</p>
                        </div>
                    @else
                        <ul class="divide-y divide-gray-200">
                            @foreach ($pharmacies as $pharmacy)
                                <li class="py-3 hover:bg-gray-50">
                                    <a href="{{ route('manage-pharmacy.show', $pharmacy->id) }}" class="block">
                                        <div class="flex items-center justify-between">
                                            <div class="flex items-center">
                                                <div class="flex-shrink-0 h-10 w-10 rounded-full bg-blue-100 flex items-center justify-center">
                                                    <i class="fas fa-clinic-medical text-blue-500"></i>
                                                </div>
                                                <div class="ml-3">
                                                    <p class="text-sm font-medium text-gray-800">{{ $pharmacy->name }}</p>
                                                    <p class="text-xs text-gray-500">{{ $pharmacy->location }}</p>
                                                </div>
                                            </div>
                                            <div class="text-gray-400">
                                                <i class="fas fa-chevron-right text-sm"></i>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            @endforeach
                        </ul>
                        
                        <!-- Pagination Links -->
                        <div class="mt-4 border-t border-gray-200 pt-3">
                            {{ $pharmacies->links() }}
                        </div>
                    @endif
                </div>
            </div>

            <!-- Add New Pharmacy Card -->
            <div class="bg-white shadow rounded-lg">
                <div class="px-4 py-4 bg-gray-800 rounded-t-lg">
                    <h3 class="text-lg font-medium text-white">
                        <i class="fas fa-plus-circle mr-2"></i>Register New Pharmacy
                    </h3>
                </div>
                <div class="p-4">
                    <form method="POST" action="{{ route('manage-pharmacy.store') }}" class="space-y-4">
                        @csrf
                        <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
                            <div class="sm:col-span-2">
                                <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Pharmacy Name</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-signature text-gray-400"></i>
                                    </div>
                                    <input type="text" name="name" id="name" class="pl-10 w-full rounded border-gray-300 @error('name') border-red-500 @enderror" value="{{ old('name') }}" placeholder="Enter pharmacy name">
                                    @error('name')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('name')
                                    <p class="mt-1 text-xs text-red-500">{{ $message }}</p>
                                @enderror
                            </div>

                            <div>
                                <label for="license_number" class="block text-sm font-medium text-gray-700 mb-1">License Number</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-id-card text-gray-400"></i>
                                    </div>
                                    <input type="text" name="license_number" id="license_number" class="pl-10 w-full rounded border-gray-300 @error('license_number') border-red-500 @enderror" value="{{ old('license_number') }}" placeholder="License #">
                                    @error('license_number')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('license_number')
                                    <p class="mt-1 text-xs text-red-500">{{ $message }}</p>
                                @enderror
                            </div>

                            <div>
                                <label for="contact_phone" class="block text-sm font-medium text-gray-700 mb-1">Contact Phone</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-phone text-gray-400"></i>
                                    </div>
                                    <input type="text" name="contact_phone" id="contact_phone" class="pl-10 w-full rounded border-gray-300 @error('contact_phone') border-red-500 @enderror" value="{{ old('contact_phone') }}" placeholder="Phone number">
                                    @error('contact_phone')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('contact_phone')
                                    <p class="mt-1 text-xs text-red-500">{{ $message }}</p>
                                @enderror
                            </div>

                            <div class="sm:col-span-2">
                                <label for="address" class="block text-sm font-medium text-gray-700 mb-1">Address</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-map-marker-alt text-gray-400"></i>
                                    </div>
                                    <input type="text" name="address" id="address" class="pl-10 w-full rounded border-gray-300 @error('address') border-red-500 @enderror" value="{{ old('address') }}" placeholder="Full address">
                                    @error('address')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('address')
                                    <p class="mt-1 text-xs text-red-500">{{ $message }}</p>
                                @enderror
                            </div>

                            <div>
                                <label for="location" class="block text-sm font-medium text-gray-700 mb-1">Location</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-map-pin text-gray-400"></i>
                                    </div>
                                    <input type="text" name="location" id="location" class="pl-10 w-full rounded border-gray-300 @error('location') border-red-500 @enderror" value="{{ old('location') }}" placeholder="City/Region">
                                    @error('location')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('location')
                                    <p class="mt-1 text-xs text-red-500">{{ $message }}</p>
                                @enderror
                            </div>

                            <div>
                                <label for="contact_email" class="block text-sm font-medium text-gray-700 mb-1">Contact Email</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-envelope text-gray-400"></i>
                                    </div>
                                    <input type="email" name="contact_email" id="contact_email" class="pl-10 w-full rounded border-gray-300 @error('contact_email') border-red-500 @enderror" value="{{ old('contact_email') }}" placeholder="Email address">
                                    @error('contact_email')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('contact_email')
                                    <p class="mt-1 text-xs text-red-500">{{ $message }}</p>
                                @enderror
                            </div>
                        </div>

                        <div class="flex justify-end pt-2">
                            <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
                                <i class="fas fa-save mr-2"></i> Register Pharmacy
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection