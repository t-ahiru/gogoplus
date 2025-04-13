@extends('layouts.app')

@section('content')
<div class="py-6">
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
            <div class="p-6 bg-white border-b border-gray-200">
                <h2 class="text-2xl font-bold">{{ $pharmacy->name }}</h2>
                
                <div class="mt-4 grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p><strong>License Number:</strong> {{ $pharmacy->license_number }}</p>
                        <p><strong>Address:</strong> {{ $pharmacy->address }}</p>
                        <p><strong>Location:</strong> {{ $pharmacy->location }}</p>
                    </div>
                    <div>
                        <p><strong>Contact Phone:</strong> {{ $pharmacy->contact_phone }}</p>
                        <p><strong>Contact Email:</strong> {{ $pharmacy->contact_email }}</p>
                    </div>
                </div>

                <div class="mt-6 flex space-x-4">
                    <a href="{{ route('manage-pharmacy.users', $pharmacy) }}" 
                       class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
                        Manage Users
                    </a>
                    <a href="{{ route('manage-pharmacy.index') }}" 
                       class="px-4 py-2 bg-gray-600 text-white rounded hover:bg-gray-700">
                        Back to List
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection