<!-- resources/views/layouts/sidebar.blade.php -->
<aside id="sidebar" class="bg-gray-900 text-white w-64 min-h-screen p-4 flex flex-col shadow-lg transition-all duration-300 ease-in-out">
    <!-- Logo and Toggle Button -->
    <div class="flex items-center justify-between mb-6">
        <a href="{{ route('dashboard') }}" class="flex items-center">
            <span class="text-2xl font-bold text-orange-500">Gogo</span><span class="text-2xl font-bold text-white">Plus</span>
        </a>
        <button id="toggle-sidebar" class="text-white focus:outline-none">
            <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
            </svg>
        </button>
    </div>

    <!-- Navigation Links -->
    <nav class="flex-1">
        <ul class="space-y-2">
            <li>
                <a href="{{ route('dashboard') }}" class="flex items-center p-2 rounded hover:bg-gray-700 {{ request()->routeIs('dashboard') ? 'bg-gray-700' : '' }}">
                    <svg class="h-5 w-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                    </svg>
                    <span class="sidebar-text whitespace-nowrap">Dashboard</span>
                </a>
            </li>
            <!-- Add other menu items similarly -->
        </ul>
    </nav>
</aside>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const sidebar = document.getElementById('sidebar');
        const toggleBtn = document.getElementById('toggle-sidebar');
        const mainContent = document.getElementById('main-content');

        // Ensure sidebar is visible by default
        if (!localStorage.getItem('sidebarCollapsed')) {
            localStorage.setItem('sidebarCollapsed', 'false');
        }

        const isCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';
        if (isCollapsed) {
            sidebar.classList.add('collapsed');
            mainContent.classList.add('full');
        } else {
            sidebar.classList.remove('collapsed');
            mainContent.classList.remove('full');
        }

        toggleBtn.addEventListener('click', function() {
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('full');
            const isNowCollapsed = sidebar.classList.contains('collapsed');
            localStorage.setItem('sidebarCollapsed', isNowCollapsed);
        });
    });
</script>

<style>
    #sidebar {
        transition: all 0.3s ease;
        display: block; /* Ensure sidebar is visible */
    }

    #sidebar.collapsed {
        width: 5rem; /* Collapsed width */
    }

    #sidebar.collapsed .sidebar-text {
        display: none; /* Hide text when collapsed */
    }

    #sidebar.collapsed a {
        justify-content: center; /* Center icons when collapsed */
    }

    #sidebar.collapsed a svg {
        margin-right: 0; /* Remove margin when collapsed */
    }
</style>