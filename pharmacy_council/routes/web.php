<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// Pharmacy Monitor Routes
// Route::prefix('pharmacy-monitor')->middleware(['auth', 'role:admin'])->group(function() {
//     Route::get('/dashboard', [PharmacyMonitorController::class, 'dashboard'])->name('pharmacy-monitor.dashboard');
//     Route::get('/sales-report', [PharmacyMonitorController::class, 'salesReport'])->name('pharmacy-monitor.sales-report');
//     Route::get('/product-report', [PharmacyMonitorController::class, 'productReport'])->name('pharmacy-monitor.product-report');
// });

// Add this to your routes/web.php
Route::middleware(['auth'])->group(function () {
    Route::get('/pharmacies', function () {
        // Assuming you have a Pharmacy model and want to show all pharmacies
        $pharmacies = App\Models\Pharmacy::all();
        return view('pharmacies.index', ['pharmacies' => $pharmacies]);
    })->name('pharmacies.index');
    
    Route::get('/pharmacies/{pharmacy}/activities', function (App\Models\Pharmacy $pharmacy) {
        return view('pharmacies.activities', ['pharmacy' => $pharmacy]);
    })->name('pharmacies.activities');
});

require __DIR__.'/auth.php';
