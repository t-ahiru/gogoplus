@extends('layouts.app')

@section('content')
<div class="py-6">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <!-- Header Section -->
        <div class="mb-8">
            <h2 class="text-2xl font-bold leading-tight text-gray-900">
                <i class="fas fa-clinic-medical text-blue-600 mr-2"></i>Pharmacy Management
            </h2>
            <p class="mt-1 text-sm text-gray-500">Select or register pharmacies keep up with their activities</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <!-- Registered Pharmacies Card -->
            <div class="bg-white overflow-hidden shadow rounded-lg">
                <div class="px-4 py-5 sm:px-6 bg-gray-900">
                    <h3 class="text-lg leading-6 font-medium text-white">
                        <i class="fas fa-store-alt mr-2"></i>Registered Pharmacies
                    </h3>
                </div>
                <div class="px-4 py-5 sm:p-6">
                    @if ($pharmacies->isEmpty())
                        <div class="text-center py-4">
                            <i class="fas fa-info-circle text-blue-500 text-4xl mb-3"></i>
                            <p class="text-gray-500">No pharmacies registered yet.</p>
                        </div>
                    @else
                        <ul class="divide-y divide-gray-200">
                            @foreach ($pharmacies as $pharmacy)
                                <li class="py-4 hover:bg-gray-50 transition-colors duration-150">
                                    <a href="{{ route('manage-pharmacy.show', $pharmacy->id) }}" class="block">
                                        <div class="flex items-center justify-between">
                                            <div class="flex items-center">
                                                <div class="flex-shrink-0 h-10 w-10 rounded-full bg-blue-100 flex items-center justify-center">
                                                    <i class="fas fa-clinic-medical text-blue-600"></i>
                                                </div>
                                                <div class="ml-4">
                                                    <p class="text-sm font-medium text-gray-900">{{ $pharmacy->name }}</p>
                                                    <p class="text-sm text-gray-500">{{ $pharmacy->location }}</p>
                                                </div>
                                            </div>
                                            <div class="text-gray-400">
                                                <i class="fas fa-chevron-right"></i>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            @endforeach
                        </ul>
                    @endif
                </div>
            </div>

            <!-- Add New Pharmacy Card -->
            <div class="bg-white overflow-hidden shadow rounded-lg">
                <div class="px-4 py-5 sm:px-6 bg-gray-900">
                    <h3 class="text-lg leading-6 font-medium text-white">
                        <i class="fas fa-plus-circle mr-2"></i>Register New Pharmacy
                    </h3>
                </div>
                <div class="px-4 py-5 sm:p-6">
                    <form method="POST" action="{{ route('manage-pharmacy.store') }}" class="space-y-6">
                        @csrf
                        <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
                            <div class="sm:col-span-2">
                                <label for="name" class="block text-sm font-medium text-gray-700">Pharmacy Name</label>
                                <div class="mt-1 relative rounded-md shadow-sm">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-signature text-gray-400"></i>
                                    </div>
                                    <input type="text" name="name" id="name" class="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md py-2 @error('name') border-red-300 text-red-900 placeholder-red-300 focus:outline-none focus:ring-red-500 focus:border-red-500 @enderror" value="{{ old('name') }}" placeholder="Enter pharmacy name">
                                    @error('name')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('name')
                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                @enderror
                            </div>

                            <div>
                                <label for="license_number" class="block text-sm font-medium text-gray-700">License Number</label>
                                <div class="mt-1 relative rounded-md shadow-sm">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-id-card text-gray-400"></i>
                                    </div>
                                    <input type="text" name="license_number" id="license_number" class="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md py-2 @error('license_number') border-red-300 text-red-900 placeholder-red-300 focus:outline-none focus:ring-red-500 focus:border-red-500 @enderror" value="{{ old('license_number') }}" placeholder="License #">
                                    @error('license_number')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('license_number')
                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                @enderror
                            </div>

                            <div>
                                <label for="contact_phone" class="block text-sm font-medium text-gray-700">Contact Phone</label>
                                <div class="mt-1 relative rounded-md shadow-sm">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-phone text-gray-400"></i>
                                    </div>
                                    <input type="text" name="contact_phone" id="contact_phone" class="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md py-2 @error('contact_phone') border-red-300 text-red-900 placeholder-red-300 focus:outline-none focus:ring-red-500 focus:border-red-500 @enderror" value="{{ old('contact_phone') }}" placeholder="Phone number">
                                    @error('contact_phone')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('contact_phone')
                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                @enderror
                            </div>

                            <div class="sm:col-span-2">
                                <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
                                <div class="mt-1 relative rounded-md shadow-sm">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-map-marker-alt text-gray-400"></i>
                                    </div>
                                    <input type="text" name="address" id="address" class="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md py-2 @error('address') border-red-300 text-red-900 placeholder-red-300 focus:outline-none focus:ring-red-500 focus:border-red-500 @enderror" value="{{ old('address') }}" placeholder="Full address">
                                    @error('address')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('address')
                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                @enderror
                            </div>

                            <div>
                                <label for="location" class="block text-sm font-medium text-gray-700">Location</label>
                                <div class="mt-1 relative rounded-md shadow-sm">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-map-pin text-gray-400"></i>
                                    </div>
                                    <input type="text" name="location" id="location" class="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md py-2 @error('location') border-red-300 text-red-900 placeholder-red-300 focus:outline-none focus:ring-red-500 focus:border-red-500 @enderror" value="{{ old('location') }}" placeholder="City/Region">
                                    @error('location')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('location')
                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                @enderror
                            </div>

                            <div>
                                <label for="contact_email" class="block text-sm font-medium text-gray-700">Contact Email</label>
                                <div class="mt-1 relative rounded-md shadow-sm">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-envelope text-gray-400"></i>
                                    </div>
                                    <input type="email" name="contact_email" id="contact_email" class="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md py-2 @error('contact_email') border-red-300 text-red-900 placeholder-red-300 focus:outline-none focus:ring-red-500 focus:border-red-500 @enderror" value="{{ old('contact_email') }}" placeholder="Email address">
                                    @error('contact_email')
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-exclamation-circle text-red-500"></i>
                                        </div>
                                    @enderror
                                </div>
                                @error('contact_email')
                                    <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                                @enderror
                            </div>
                        </div>

                        <div class="flex justify-end">
                            <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
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