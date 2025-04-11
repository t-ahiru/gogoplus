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
                        <!-- Change this in app.blade.php -->
                        <li>
                            <a href="{{ route('pharmacies.index') }}" class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('pharmacies.*') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-users mr-2"></i>
                                    Manage Users
                            </a>
                        </li>
                        <li>
                            <a href="#" class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('inventory.*') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-box mr-2"></i> Inventory
                            </a>
                        </li>
                        <li>
                            <a href="#" class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('stock.*') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-warehouse mr-2"></i>Stocks
                            </a>
                        </li>
                        <li>
                            <a href="#" class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('orders.*') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-file-invoice mr-2"></i>Orders
                            </a>
                        </li>
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
                    {{ $slot }}
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