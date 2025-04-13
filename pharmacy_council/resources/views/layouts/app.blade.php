<!-- resources/views/layouts/app.blade.php -->
@props(['header'])

<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>{{ config('app.name', 'pharmacy council') }}</title>

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

        <!-- Scripts -->
        @vite(['resources/css/app.css', 'resources/js/app.js'])
    </head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <body class="font-sans antialiased">
        <div class="flex min-h-screen" 
             x-data="{ sidebarOpen: window.innerWidth > 768 }" 
             @toggle-sidebar.window="sidebarOpen = !sidebarOpen"
             @resize.window="sidebarOpen = window.innerWidth > 768">
            
            <!-- Sidebar -->
            <aside x-show="sidebarOpen"
                   x-transition:enter="transition ease-in-out duration-300 transform"
                   x-transition:enter-start="-translate-x-full"
                   x-transition:enter-end="translate-x-0"
                   x-transition:leave="transition ease-in-out duration-300 transform"
                   x-transition:leave-start="translate-x-0"
                   x-transition:leave-end="-translate-x-full"
                   class="w-64 bg-gray-900 text-white flex flex-col fixed h-full z-10">
                <!-- Sidebar Header -->
                <div class="p-4 border-b border-blue-800">
                    <h1 class="text-xl font-semibold">Pharmacy Council</h1>
                </div>
                
                <!-- Sidebar Navigation -->
                <nav class="flex-1 p-4">
                    <ul class="space-y-2">
                        <li>
                            <a href="{{ route('dashboard') }}" class="flex items-center p-2 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('dashboard') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-chart-line mr-2"></i>
                                Dashboard
                            </a>
                        </li>
                        <!-- Updated Manage Pharmacies Section with Submenu -->
                        <li x-data="{ open: false }" 
                            @mouseenter="open = true" 
                            @mouseleave="open = false">
                                <a href="{{ route('manage-pharmacy.index') }}" 
                                class="flex items-center p-2 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('manage-pharmacy.*') ? 'bg-blue-700' : '' }}">
                                    <i class="fas fa-prescription-bottle-alt mr-2"></i>
                                         Manage Pharmacy 
                                <i class="fas fa-chevron-down ml-auto" x-bind:class="{ 'fa-chevron-up': open, 'fa-chevron-down': !open }"></i>
                             </a>
                            <!-- Submenu for Pharmacies -->
                            <ul x-show="open" 
                            x-transition:enter="transition ease-out duration-200"
                                x-transition:enter-start="opacity-0 scale-95"
                                x-transition:enter-end="opacity-100 scale-100"
                                x-transition:leave="transition ease-in duration-150"
                                 x-transition:leave-start="opacity-100 scale-100"
                                x-transition:leave-end="opacity-0 scale-95"
                                class="mt-1 space-y-1 pl-4">
                                    @foreach (\App\Models\Pharmacy::all() as $pharmacy)
                                <li>
                                     <a href="{{ route('manage-pharmacy.show', $pharmacy->id) }}" 
                                        class="flex items-center p-2 rounded hover:bg-blue-600 transition-colors {{ request()->routeIs('manage-pharmacy.show') && request()->segment(2) == $pharmacy->id ? 'bg-blue-600' : '' }}">
                                        <i class="fas fa-store mr-2"></i>
                                        {{ $pharmacy->name }}
                                    </a>
                                </li>
                                     @endforeach
                             </ul>
                            </li>
                       <!-- Council User (only for role_id === 1) -->
@php $user = Auth::user(); @endphp
@if ($user && $user->role_id === 1)
    <li>
        <a href="{{ route('council_user.index') }}"
           class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('council_user.*') ? 'bg-blue-700' : '' }}">
            <i class="fas fa-users mr-2"></i> Manage Users
        </a>
    </li>
@endif
                        
                        <li>
                            <a href="#" class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('settings.*') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-cog mr-2"></i> Settings
                            </a>
                        </li>
                        <li>
                            <a href="#" class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('activity.*') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-history mr-2"></i> Activity Log
                            </a>
                        </li>
                    </ul>
                </nav>
 

                <!-- Sidebar Footer -->
                <div class="p-4 border-t border-blue-800">
                    <form method="POST" action="{{ route('logout') }}">
                        @csrf
                        <button type="submit" class="w-full text-left flex items-center p-2 rounded hover:bg-blue-400 transition-colors">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                            </svg>
                            Logout
                        </button>
                    </form>
                </div>
            </aside>

            <!-- Main Content -->
            <div id="main-content" 
                 x-bind:class="{ 'md:ml-64': sidebarOpen }"
                 class="flex-1 flex flex-col transition-all duration-300 ease-in-out">
                <!-- Navigation -->
                @include('layouts.navigation')

                <!-- Page Heading -->
                @isset($header)
                    <header class="bg-white shadow">
                        <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                            {{ $header }}
                        </div>
                    </header>
                @endisset

                <!-- Page Content -->
                <main class="flex-1 bg-gray-100 p-6">
                    @yield('content')
                </main>
            </div>
        </div>

        <script>
            // Handle window resize events
            window.addEventListener('resize', function() {
                window.dispatchEvent(new CustomEvent('resize'));
            });
        </script>
    </body>
</html>