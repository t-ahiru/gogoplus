@extends('layouts.app')

@section('header')
    <h2 class="font-semibold text-xl text-gray-800 leading-tight">
        <i class="fas fa-tachometer-alt mr-2 text-blue-500"></i>Dashboard Overview
    </h2>
@endsection

@section('content')
    <div class="py-8">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <!-- Welcome Card -->
            <div class="bg-white overflow-hidden shadow-lg sm:rounded-lg mb-8 border border-blue-100 hover:shadow-xl transition-shadow duration-300">
                <div class="p-6 bg-gradient-to-r from-blue-50 to-indigo-50">
                    <div class="flex flex-col md:flex-row items-center md:items-start md:space-x-6">
                        <div class="flex-shrink-0 bg-blue-100 p-4 rounded-full shadow-inner">
                            <i class="fas fa-clinic-medical text-blue-600 text-3xl"></i>
                        </div>
                        <div class="mt-4 md:mt-0 text-center md:text-left">
                            <h3 class="text-2xl md:text-3xl font-bold text-gray-800">Welcome to Pharmacy Council Portal</h3>
                            <p class="mt-2 text-gray-600 max-w-2xl">Your centralized platform for pharmacy management, compliance tracking, and regulatory oversight.</p>
                            <div class="mt-4 flex flex-wrap justify-center md:justify-start gap-2">
                                <span class="px-3 py-1 bg-blue-100 text-blue-800 text-xs font-medium rounded-full">Secure</span>
                                <span class="px-3 py-1 bg-green-100 text-green-800 text-xs font-medium rounded-full">Efficient</span>
                                <span class="px-3 py-1 bg-purple-100 text-purple-800 text-xs font-medium rounded-full">Compliant</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <!-- Pharmacies Card -->
                <div class="bg-white overflow-hidden shadow rounded-lg hover:shadow-lg transition-all duration-300 border-l-4 border-blue-500">
                    <div class="px-4 py-5 sm:p-6">
                        <div class="flex items-center">
                            <div class="flex-shrink-0 bg-blue-100 rounded-full p-3 shadow-sm">
                                <i class="fas fa-clinic-medical text-blue-600 text-xl"></i>
                            </div>
                            <div class="ml-5 w-0 flex-1">
                                <dl>
                                    <dt class="text-sm font-medium text-gray-500 truncate">Registered Pharmacies</dt>
                                    <dd class="flex items-baseline">
                                        <div class="text-2xl font-semibold text-gray-900">{{ $pharmaciesCount ?? '0' }}</div>
                                        <span class="ml-2 text-xs font-medium text-green-600 bg-green-100 px-2 py-0.5 rounded-full">+2.4%</span>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                        <div class="mt-4">
                            <a href="{{ route('manage-pharmacy.index') }}" class="inline-flex items-center text-sm font-medium text-blue-600 hover:text-blue-500 group">
                                View all pharmacies <i class="fas fa-arrow-right ml-1 transition-transform group-hover:translate-x-1"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Additional Stat Cards (Example) -->
                <div class="bg-white overflow-hidden shadow rounded-lg hover:shadow-lg transition-all duration-300 border-l-4 border-green-500">
                    <div class="px-4 py-5 sm:p-6">
                        <div class="flex items-center">
                            <div class="flex-shrink-0 bg-green-100 rounded-full p-3 shadow-sm">
                                <i class="fas fa-user-md text-green-600 text-xl"></i>
                            </div>
                            <div class="ml-5 w-0 flex-1">
                                <dl>
                                    <dt class="text-sm font-medium text-gray-500 truncate">Active Pharmacists</dt>
                                    <dd class="flex items-baseline">
                                        <div class="text-2xl font-semibold text-gray-900">142</div>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                        <div class="mt-4">
                            <a href="#" class="inline-flex items-center text-sm font-medium text-green-600 hover:text-green-500 group">
                                View details <i class="fas fa-arrow-right ml-1 transition-transform group-hover:translate-x-1"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow rounded-lg hover:shadow-lg transition-all duration-300 border-l-4 border-purple-500">
                    <div class="px-4 py-5 sm:p-6">
                        <div class="flex items-center">
                            <div class="flex-shrink-0 bg-purple-100 rounded-full p-3 shadow-sm">
                                <i class="fas fa-file-alt text-purple-600 text-xl"></i>
                            </div>
                            <div class="ml-5 w-0 flex-1">
                                <dl>
                                    <dt class="text-sm font-medium text-gray-500 truncate">Pending Inspections</dt>
                                    <dd class="flex items-baseline">
                                        <div class="text-2xl font-semibold text-gray-900">8</div>
                                        <span class="ml-2 text-xs font-medium text-red-600 bg-red-100 px-2 py-0.5 rounded-full">Urgent</span>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                        <div class="mt-4">
                            <a href="#" class="inline-flex items-center text-sm font-medium text-purple-600 hover:text-purple-500 group">
                                Review now <i class="fas fa-arrow-right ml-1 transition-transform group-hover:translate-x-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="bg-white overflow-hidden shadow rounded-lg mb-8 border border-gray-100 hover:shadow-lg transition-shadow duration-300">
                <div class="px-4 py-5 sm:px-6 bg-gradient-to-r from-blue-50 to-gray-50 border-b border-gray-200">
                    <h3 class="text-lg font-medium leading-6 text-gray-900 flex items-center">
                        <i class="fas fa-bolt text-yellow-500 mr-2"></i>Quick Actions
                    </h3>
                </div>
                <div class="px-4 py-5 sm:p-6 grid grid-cols-1 md:grid-cols-3 gap-4">
                    <!-- Manage Pharmacies -->
                    <a href="{{ route('manage-pharmacy.index') }}" class="group flex items-start p-4 border border-gray-200 rounded-lg hover:border-blue-300 hover:bg-blue-50 transition-all duration-200 hover:-translate-y-1">
                        <div class="flex-shrink-0 bg-blue-100 group-hover:bg-blue-200 p-3 rounded-lg shadow-sm">
                            <i class="fas fa-clinic-medical text-blue-600 text-lg"></i>
                        </div>
                        <div class="ml-4">
                            <h4 class="text-sm font-semibold text-gray-900 group-hover:text-blue-700">Manage Pharmacies</h4>
                            <p class="mt-1 text-xs text-gray-500">View, edit, and approve pharmacy registrations</p>
                            <span class="mt-2 inline-block text-xs font-medium text-blue-600">Go to module →</span>
                        </div>
                    </a>

                    <!-- Add New User -->
                    <a href="#" class="group flex items-start p-4 border border-gray-200 rounded-lg hover:border-green-300 hover:bg-green-50 transition-all duration-200 hover:-translate-y-1">
                        <div class="flex-shrink-0 bg-green-100 group-hover:bg-green-200 p-3 rounded-lg shadow-sm">
                            <i class="fas fa-user-plus text-green-600 text-lg"></i>
                        </div>
                        <div class="ml-4">
                            <h4 class="text-sm font-semibold text-gray-900 group-hover:text-green-700">Add New User</h4>
                            <p class="mt-1 text-xs text-gray-500">Register new pharmacy staff members</p>
                            <span class="mt-2 inline-block text-xs font-medium text-green-600">Go to module →</span>
                        </div>
                    </a>

                    <!-- Generate Reports -->
                    <a href="#" class="group flex items-start p-4 border border-gray-200 rounded-lg hover:border-purple-300 hover:bg-purple-50 transition-all duration-200 hover:-translate-y-1">
                        <div class="flex-shrink-0 bg-purple-100 group-hover:bg-purple-200 p-3 rounded-lg shadow-sm">
                            <i class="fas fa-file-alt text-purple-600 text-lg"></i>
                        </div>
                        <div class="ml-4">
                            <h4 class="text-sm font-semibold text-gray-900 group-hover:text-purple-700">Generate Reports</h4>
                            <p class="mt-1 text-xs text-gray-500">Create compliance and activity reports</p>
                            <span class="mt-2 inline-block text-xs font-medium text-purple-600">Go to module →</span>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Recent Activity (Example Section) -->
            <div class="bg-white overflow-hidden shadow rounded-lg">
                <div class="px-4 py-5 sm:px-6 bg-gradient-to-r from-gray-50 to-blue-50 border-b border-gray-200">
                    <h3 class="text-lg font-medium leading-6 text-gray-900 flex items-center">
                        <i class="fas fa-history text-blue-500 mr-2"></i>Recent Activity
                    </h3>
                </div>
                <div class="bg-white px-4 py-5 sm:p-6">
                    <ul class="divide-y divide-gray-200">
                        <li class="py-4">
                            <div class="flex space-x-3">
                                <div class="flex-shrink-0 bg-blue-100 p-2 rounded-full">
                                    <i class="fas fa-user-check text-blue-600 text-sm"></i>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm text-gray-800">
                                        <span class="font-semibold">Dr. Sarah Johnson</span> approved a new pharmacy registration
                                    </p>
                                    <p class="text-xs text-gray-500 mt-1">2 hours ago</p>
                                </div>
                            </div>
                        </li>
                        <li class="py-4">
                            <div class="flex space-x-3">
                                <div class="flex-shrink-0 bg-green-100 p-2 rounded-full">
                                    <i class="fas fa-file-upload text-green-600 text-sm"></i>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm text-gray-800">
                                        <span class="font-semibold">MedPlus Pharmacy</span> submitted renewal documents
                                    </p>
                                    <p class="text-xs text-gray-500 mt-1">5 hours ago</p>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <div class="mt-4 text-center">
                        <a href="#" class="text-sm font-medium text-blue-600 hover:text-blue-500">
                            View all activity <i class="fas fa-arrow-right ml-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection