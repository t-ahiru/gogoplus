@extends('layouts.app')

@section('content')
<div class="py-6">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <!-- Pharmacy Header Section -->
        <div class="bg-white shadow rounded-lg overflow-hidden mb-6">
            <div class="px-4 py-5 sm:px-6 bg-gray-900">
                <h2 class="text-xl font-bold text-white">
                    <i class="fas fa-clinic-medical mr-2"></i>{{ $pharmacy->name }}
                </h2>
            </div>
            <div class="px-4 py-5 sm:p-6 grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <p class="text-sm font-medium text-gray-500">License Number</p>
                    <p class="mt-1 text-sm text-gray-900">{{ $pharmacy->license_number }}</p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-500">Location</p>
                    <p class="mt-1 text-sm text-gray-900">{{ $pharmacy->location }}</p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-500">Address</p>
                    <p class="mt-1 text-sm text-gray-900">{{ $pharmacy->address }}</p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-500">Contact</p>
                    <p class="mt-1 text-sm text-gray-900">
                        <i class="fas fa-phone mr-1 text-blue-500"></i> {{ $pharmacy->contact_phone }}<br>
                        <i class="fas fa-envelope mr-1 text-blue-500"></i> {{ $pharmacy->contact_email }}
                    </p>
                </div>
            </div>
        </div>

        <!-- Users Card -->
        <div class="bg-white shadow rounded-lg overflow-hidden">
            <div class="px-4 py-5 sm:px-6 bg-gray-900">
                <h3 class="text-lg font-medium text-white">
                    <i class="fas fa-users mr-2"></i>User List
                </h3>
            </div>
            <div class="px-4 py-5 sm:p-6">
                @if ($users->isEmpty())
                    <div class="text-center py-8">
                        <i class="fas fa-user-slash text-gray-400 text-4xl mb-3"></i>
                        <p class="text-gray-500">No users found in this pharmacy.</p>
                    </div>
                @else
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Name
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Email
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Actions
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                @foreach ($users as $user)
                                <tr class="hover:bg-gray-50 transition-colors duration-150">
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10 rounded-full bg-blue-100 flex items-center justify-center">
                                                <i class="fas fa-user text-blue-600"></i>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">{{ $user->name }}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900">{{ $user->email }}</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                       <a href="{{ route('manage-pharmacy.users.activity', ['pharmacy' => $pharmacy->id, 'user' => $user->id]) }}"
                                           class="inline-flex items-center px-3 py-1 border border-transparent text-xs font-medium rounded-full shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                            <i class="fas fa-chart-line mr-1"></i> Track Activity
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                @endif
            </div>
        </div>
    </div>
</div>
@endsection