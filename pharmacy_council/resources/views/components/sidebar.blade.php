<!-- resources/views/components/sidebar.blade.php -->
<div class="flex">
    <!-- Sidebar -->
    <div id="sidebar" class="sidebar bg-gray-900 text-white transition-all duration-300">
        <div class="sidebar-header p-4 flex justify-between items-center">
            <div class="flex items-center">
                <button id="toggle-sidebar" class="text-white focus:outline-none">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                    </svg>
                </button>
                <h3 class="sidebar-title ml-3 text-lg font-semibold">GogoPlus</h3>
            </div>
        </div>
        <div class="sidebar-content">
            <ul class="sidebar-menu">
                <li class="menu-item">
                    <a href="#" class="flex items-center p-4 hover:bg-gray-800">
                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                        </svg>
                        Dashboard
                    </a>
                </li>
                <li class="menu-item">
                    <a href="#" class="flex items-center p-4 hover:bg-gray-800">
                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V7m-9 4h9"></path>
                        </svg>
                        Product
                    </a>
                </li>
                <li class="menu-item">
                    <a href="#" class="flex items-center p-4 hover:bg-gray-800">
                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path>
                        </svg>
                        Purchase
                    </a>
                </li>
                <li class="menu-item">
                    <a href="#" class="flex items-center p-4 hover:bg-gray-800">
                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h18M9 3v18m-6-6h18"></path>
                        </svg>
                        Sale
                    </a>
                </li>
                <!-- Add more menu items as needed -->
            </ul>
        </div>
    </div>

    <!-- Main Content Wrapper -->
    <div id="main-content" class="flex-1 transition-all duration-300">
        {{ $slot }}
    </div>
</div>

<style>
    .sidebar {
        width: 250px;
        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        overflow-y: auto;
    }

    .sidebar.collapsed {
        width: 0;
        overflow: hidden;
    }

    .sidebar-header {
        background-color: #1f2937;
    }

    .sidebar-title {
        background: linear-gradient(to right, #3b82f6, #f97316);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .sidebar-menu {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .menu-item a {
        text-decoration: none;
        color: #d1d5db;
        transition: background-color 0.3s;
    }

    #main-content {
        margin-left: 250px;
    }

    #main-content.full {
        margin-left: 0;
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const sidebar = document.getElementById('sidebar');
        const toggleBtn = document.getElementById('toggle-sidebar');
        const mainContent = document.getElementById('main-content');

        toggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('full');
        });
    });
</script>