import './bootstrap';
import Alpine from 'alpinejs';
import Chart from 'chart.js/auto'; // Import Chart.js

// Initialize Alpine
window.Alpine = Alpine;

// Make Chart available globally
window.Chart = Chart;

// Alpine store for sidebar state
document.addEventListener('alpine:init', () => {
    Alpine.store('sidebar', {
        open: window.innerWidth > 768,
        
        toggle() {
            this.open = !this.open;
        },
        
        handleResize() {
            this.open = window.innerWidth > 768;
        }
    });

    // Alpine component for charts
    Alpine.data('salesChart', () => ({
        chart: null,
        
        init() {
            // Initialize chart when component mounts
            this.$nextTick(() => {
                this.initChart();
            });
        },
        
        initChart() {
            const ctx = this.$refs.canvas.getContext('2d');
            this.chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: [],
                    datasets: [{
                        label: 'Sales Data',
                        data: [],
                        borderColor: 'rgba(79, 70, 229, 1)',
                        backgroundColor: 'rgba(79, 70, 229, 0.1)',
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        },
        
        updateChart(data) {
            if (this.chart) {
                this.chart.data.labels = data.dates;
                this.chart.data.datasets[0].data = data.quantities;
                this.chart.update();
            }
        }
    }));
});

Alpine.start();

// Resize handler
window.addEventListener('resize', () => {
    Alpine.store('sidebar').handleResize();
});