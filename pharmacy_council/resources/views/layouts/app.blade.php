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
               class="w-64 bg-gray-900 text-white flex flex-col fixed h-full z-10 transition-all duration-300 ease-in-out"
               x-bind:class="{ 'w-16': !sidebarOpen }">
            <!-- Sidebar Header -->
            <div class="p-4 border-b border-blue-800 flex items-center justify-between">
                <h1 class="text-xl font-semibold">Pharmacy Council</h1>
                <button @click="sidebarOpen = !sidebarOpen" class="text-white focus:outline-none md:hidden">
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                    </svg>
                </button>
            </div>
            
            <!-- Sidebar Navigation -->
            <nav class="flex-1 p-4">
                <ul class="space-y-2">
                    <li>
                        <a href="{{ route('dashboard') }}" @click.stop class="flex items-center p-2 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('dashboard') ? 'bg-blue-700' : '' }}">
                            <i class="fas fa-chart-line mr-2"></i>
                            <span x-show="sidebarOpen">Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="{{ route('manage-pharmacy.index') }}" @click.stop class="flex items-center p-2 rounded hover:bg-blue-700 transition-colors {{ request()->routeIs('manage-pharmacy.*') ? 'bg-blue-700' : '' }}">
                            <i class="fas fa-prescription-bottle-alt mr-2"></i>
                            <span x-show="sidebarOpen">Manage Pharmacy</span>
                        </a>
                    </li>
                    <li>
                        <a href="{{ route('pharmacy.records') }}" @click.stop class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('pharmacy.records') ? 'bg-blue-700' : '' }}">
                            <i class="fas fa-file-medical mr-2"></i>
                            <span x-show="sidebarOpen">Pharmacy Records</span>
                        </a>
                        <li class="mb-2">
                <a href="{{ route('pharmacy.purchase-records') }}" class="block p-4 hover:bg-gray-700">Pharmacy Purchase Records</a>
            </li>
            <li class="mb-2">
                <a href="{{ route('audit-trail.index') }}" class="block p-4 hover:bg-gray-700 {{ Route::is('audit-trail.index') ? 'bg-gray-700' : '' }}">Audit Trail</a>
            </li>
                    </li>
                    @php $user = Auth::user(); @endphp
                    @if ($user && $user->role_id === 1)
                        <li>
                            <a href="{{ route('council_user.index') }}" @click.stop class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('council_user.*') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-users mr-2"></i>
                                <span x-show="sidebarOpen">Manage Users</span>
                            </a>
                        </li>
                    @endif
                    @if ($user && $user->role_id === 1)
                        <li>
                            <a href="{{ route('data_requests.create') }}" @click.stop class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('data_requests.*') ? 'bg-blue-700' : '' }}">
                                <i class="fas fa-file-download mr-2"></i>
                                <span x-show="sidebarOpen">Request Data</span>
                            </a>
                        </li>
                    @endif
                    <li>
                        <a href="{{ route('settings.index') }}" @click.stop class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('settings.*') ? 'bg-blue-700' : '' }}">
                            <i class="fas fa-cog mr-2"></i>
                            <span x-show="sidebarOpen">Settings</span>
                        </a>
                    </li>
                    <li>
                        <a href="{{ route('activity.index') }}" @click.stop class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('activity.*') ? 'bg-blue-700' : '' }}">
                            <i class="fas fa-history mr-2"></i>
                            <span x-show="sidebarOpen">Activity Log</span>
                        </a>
                    </li>
                    <li>
                        <a href="{{ route('drug_search.search') }}" @click.stop class="flex items-center p-2 rounded hover:bg-blue-400 transition-colors {{ request()->routeIs('drug_search.*') ? 'bg-blue-700' : '' }}">
                            <i class="fas fa-search mr-2"></i>
                            <span x-show="sidebarOpen">Search Drug</span>
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
                        <span x-show="sidebarOpen">Logout</span>
                    </button>
                </form>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="flex-1 ml-0 md:ml-64 transition-all duration-300 ease-in-out">
            <header class="bg-gray-800 text-white p-4 flex items-center justify-between">
                <div class="flex items-center">
                    <button @click="$dispatch('toggle-sidebar')" class="text-white focus:outline-none mr-4">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                        </svg>
                    </button>
                    <h2 class="text-xl font-semibold">{{ $header ?? 'Dashboard' }}</h2>
                </div>
            </header>

            <main class="p-6">
                @yield('content')
            </main>
        </div>
    </div>
</body>
</html>