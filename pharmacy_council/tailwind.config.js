import defaultTheme from 'tailwindcss/defaultTheme';
import forms from '@tailwindcss/forms';

/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
    ],

    theme: {
        extend: {
            fontFamily: {
                sans: ['Figtree', ...defaultTheme.fontFamily.sans],
            },
            // Add custom colors to match the dashboard in the image
            colors: {
                primary: {
                    dark: '#1a202c', // Matches the dark background (similar to bg-gray-900)
                    light: '#2d3748', // Slightly lighter for hover effects (similar to hover:bg-gray-800)
                },
                accent: {
                    orange: '#f6ad55', // Matches the orange used in "GogoPlus" logo (similar to text-orange-500)
                },
            },
            // Add custom spacing for sidebar width
            spacing: {
                'sidebar-full': '16rem', // 256px, equivalent to w-64
                'sidebar-collapsed': '4rem', // 64px, equivalent to w-16
            },
        },
    },

    plugins: [forms],
};