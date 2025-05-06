<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>{{ config('app.name', 'Laravel') }}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="font-sans antialiased bg-gray-100">
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
               class="w-64 bg-gray-900 text-white flex flex-col fixed h-full z-20 transition-all duration-300 ease-in-out"
               x-bind:class="{ 'w-16': !sidebarOpen }">
            
            <!-- Sidebar Header -->
            <div class="p-4 border-b border-blue-800 flex items-center justify-between">
                <h1 class="text-xl font-semibold whitespace-nowrap" x-show="sidebarOpen">Pharmacy Council</h1>
                <button @click="sidebarOpen = !sidebarOpen" class="text-white focus:outline-none md:hidden">
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                    </svg>
                </button>
            </div>
            
            <!-- Scrollable Sidebar Navigation -->
            <div class="flex-1 overflow-y-auto">
                <nav class="p-4">
                    <ul class="space-y-1">
                        <!-- Dashboard -->
                        <li>
                            <a href="{{ route('dashboard') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('dashboard') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-chart-line text-lg mr-3 w-5 text-center"></i>
                                <span x-show="sidebarOpen" class="whitespace-nowrap">Dashboard</span>
                            </a>
                        </li>
                
                        <!-- Pharmacy Management -->
                        <li>
                            <a href="{{ route('manage-pharmacy.index') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('manage-pharmacy.*') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-prescription-bottle-alt text-lg mr-3 w-5 text-center"></i>
                                <span x-show="sidebarOpen" class="whitespace-nowrap">Manage Pharmacy</span>
                            </a>
                        </li>
                
                        <!-- Records Section -->
                        <li>
                            <a href="{{ route('pharmacy.records') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('pharmacy.records') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-file-medical text-lg mr-3 w-5 text-center"></i>
                                <span x-show="sidebarOpen" class="whitespace-nowrap">Pharmacy Records</span>
                            </a>
                        </li>
                
                        <li>
                            <a href="{{ route('pharmacy.purchase-records') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('pharmacy.purchase-records') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-shopping-cart text-lg mr-3 w-5 text-center"></i>
                                <span x-show="sidebarOpen" class="whitespace-nowrap">Purchase Records</span>
                            </a>
                        </li>
                
                        <li>
                            <a href="{{ route('audit-trail.index') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('audit-trail.index') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-clipboard-check text-lg mr-3 w-5 text-center"></i>
                                <span x-show="sidebarOpen" class="whitespace-nowrap">Audit Trail</span>
                            </a>
                        </li>
                
                        <!-- Admin Tools -->
                        @php $user = Auth::user(); @endphp
                        @if ($user && $user->role_id === 1)
                            <li>
                                <a href="{{ route('council_user.index') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('council_user.*') ? 'bg-blue-700' : '' }}">
                                    <i class="fas fa-users text-lg mr-3 w-5 text-center"></i>
                                    <span x-show="sidebarOpen" class="whitespace-nowrap">Manage Users</span>
                                </a>
                            </li>
                
                            <li>
                                <a href="{{ route('data_requests.create') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('data_requests.*') ? 'bg-blue-700' : '' }}">
                                    <i class="fas fa-file-download text-lg mr-3 w-5 text-center"></i>
                                    <span x-show="sidebarOpen" class="whitespace-nowrap">Request Data</span>
                                </a>
                            </li>
                        @endif
                
                        <!-- Search Drug -->
<li>
    <a href="{{ route('drug_search.search') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('drug_search.search') ? 'bg-blue-700' : '' }}">
        <i class="fas fa-search text-lg mr-3 w-5 text-center"></i>
        <span x-show="sidebarOpen" class="whitespace-nowrap">Search Drug</span>
    </a>
</li>

<!-- Track Expiry -->
<li>
    <a href="{{ route('drug_search.track_expiry') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('drug_search.track_expiry') ? 'bg-blue-700' : '' }}">
        <i class="fas fa-calendar text-lg mr-3 w-5 text-center"></i>
        <span x-show="sidebarOpen" class="whitespace-nowrap">Track Expiry</span>
    </a>
</li>
                        
                        <li>
                            <a href="{{ route('sales.trend') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('sales.trend') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-chart-bar text-lg mr-3 w-5 text-center"></i>
                                <span x-show="sidebarOpen" class="whitespace-nowrap">Sales Trend</span>
                            </a>
                        </li>
                
                        <!-- System Settings -->
                        <li>
                            <a href="{{ route('settings.index') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('settings.*') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-cog text-lg mr-3 w-5 text-center"></i>
                                <span x-show="sidebarOpen" class="whitespace-nowrap">Settings</span>
                            </a>
                        </li>
                
                        <li>
                            <a href="{{ route('activity.index') }}" @click.stop class="flex items-center p-3 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('activity.*') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-history text-lg mr-3 w-5 text-center"></i>
                                <span x-show="sidebarOpen" class="whitespace-nowrap">Activity Log</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>

            <!-- Sidebar Footer -->
            <div class="p-4 border-t border-blue-800">
                <form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <button type="submit" class="w-full text-left flex items-center p-3 rounded hover:bg-blue-700 transition-colors">
                        <i class="fas fa-sign-out-alt text-lg mr-3 w-5 text-center"></i>
                        <span x-show="sidebarOpen" class="whitespace-nowrap">Logout</span>
                    </button>
                </form>
            </div>
        </aside>

        <!-- Main Content Area -->
        <div class="flex-1 transition-all duration-300 ease-in-out" 
             :class="{'ml-0': !sidebarOpen, 'md:ml-64': sidebarOpen}">
            
            <!-- Navigation -->
            <nav x-data="{ open: false }" class="bg-gray-900 border-b border-gray-100">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex justify-between h-16">
                        <div class="flex">
                            <!-- Sidebar Toggle Button -->
                            <div class="shrink-0 flex items-center mr-4">
                                <button @click="$dispatch('toggle-sidebar')" class="text-gray-400 hover:text-gray-500 focus:outline-none">
                                    <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                                    </svg>
                                </button>
                            </div>

                            <!-- Logo -->
                            <div class="shrink-0 flex items-center">
                                <a href="{{ route('dashboard') }}">
                                    <x-application-logo class="block h-9 w-auto fill-current text-gray-800" />
                                </a>
                            </div>
                        </div>

                        <!-- Settings Dropdown -->
                        <div class="hidden sm:flex sm:items-center sm:ms-6">
                            <x-dropdown align="right" width="48">
                                <x-slot name="trigger">
                                    <button class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150">
                                        <div>{{ Auth::user()->name }}</div>
                                        <div class="ms-1">
                                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                                <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                                            </svg>
                                        </div>
                                    </button>
                                </x-slot>
                                <x-slot name="content">
                                    <x-dropdown-link :href="route('profile.edit')">
                                        {{ __('Profile') }}
                                    </x-dropdown-link>
                                    <form method="POST" action="{{ route('logout') }}">
                                        @csrf
                                        <x-dropdown-link :href="route('logout')"
                                                onclick="event.preventDefault();
                                                            this.closest('form').submit();">
                                            {{ __('Log Out') }}
                                        </x-dropdown-link>
                                    </form>
                                </x-slot>
                            </x-dropdown>
                        </div>

                        <!-- Hamburger -->
                        <div class="-me-2 flex items-center sm:hidden">
                            <button @click="open = !open" class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 focus:text-gray-500 transition duration-150 ease-in-out">
                                <svg class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                                    <path :class="{'hidden': open, 'inline-flex': !open }" class="inline-flex" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                                    <path :class="{'hidden': !open, 'inline-flex': open }" class="hidden" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Responsive Navigation Menu -->
                <div :class="{'block': open, 'hidden': !open}" class="hidden sm:hidden">
                    <div class="pt-2 pb-3 space-y-1">
                        <x-responsive-nav-link :href="route('dashboard')" :active="request()->routeIs('dashboard')">
                            {{ __('Dashboard') }}
                        </x-responsive-nav-link>
                    </div>
                    <div class="pt-4 pb-1 border-t border-gray-200">
                        <div class="px-4">
                            <div class="font-medium text-base text-gray-800">{{ Auth::user()->name }}</div>
                            <div class="font-medium text-sm text-gray-500">{{ Auth::user()->email }}</div>
                        </div>
                        <div class="mt-3 space-y-1">
                            <x-responsive-nav-link :href="route('profile.edit')">
                                {{ __('Profile') }}
                            </x-responsive-nav-link>
                            <form method="POST" action="{{ route('logout') }}">
                                @csrf
                                <x-responsive-nav-link :href="route('logout')"
                                        onclick="event.preventDefault();
                                                    this.closest('form').submit();">
                                    {{ __('Log Out') }}
                                </x-responsive-nav-link>
                            </form>
                        </div>
                    </div>
                </div>
            </nav>

            <!-- Page Content -->
            <main class="p-6">
                @yield('content')
            </main>
        </div>
    </div>
</body>
</html>