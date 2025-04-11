// resources/js/app.js
import './bootstrap';

import Alpine from 'alpinejs';

window.Alpine = Alpine;

// Initialize Alpine store for sidebar state
document.addEventListener('alpine:init', () => {
    Alpine.store('sidebar', {
        open: window.innerWidth > 768,
        
        toggle() {
            this.open = !this.open;
            // Persist state in localStorage if needed
            // localStorage.setItem('sidebarOpen', this.open);
        },
        
        // Handle window resize
        handleResize() {
            this.open = window.innerWidth > 768;
        }
    });
});

// Start Alpine
Alpine.start();

// Add resize event listener
window.addEventListener('resize', () => {
    Alpine.store('sidebar').handleResize();
    // Dispatch resize event for components to react
    window.dispatchEvent(new CustomEvent('resize'));
});

