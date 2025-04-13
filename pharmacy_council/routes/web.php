<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\PharmacyController;
use App\Http\Controllers\DashboardController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CouncilUserController;
use Illuminate\Support\Facades\Auth;

Auth::routes();
Route::resource('council_user', CouncilUserController::class)->middleware(['auth']);
Route::get('/council_user', [CouncilUserController::class, 'index'])->name('council_user.index');
Route::get('/council_user/create', [CouncilUserController::class, 'create'])->name('council_user.create');
Route::post('/council_user', [CouncilUserController::class, 'store'])->name('council_user.store');
Route::delete('/council_user/{id}', [CouncilUserController::class, 'destroy'])->name('council_user.destroy');
Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

    // Profile Routes
    Route::middleware('auth')->group(function () {
        Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
        Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
        Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    });
    // Pharmacy Management Routes
    Route::prefix('manage-pharmacy')->group(function () {
        // Main pharmacy management
        Route::get('/', [PharmacyController::class, 'index'])->name('manage-pharmacy.index');
        Route::post('/', [PharmacyController::class, 'store'])->name('manage-pharmacy.store');
        
        // Individual pharmacy operations
        Route::prefix('{pharmacy}')->group(function () {
            Route::get('/', [PharmacyController::class, 'show'])->name('manage-pharmacy.show');
            Route::get('/users', [PharmacyController::class, 'manageUsers'])->name('manage-pharmacy.users');
            Route::get('/users/{user}/activity', [PharmacyController::class, 
            'trackActivity'])->name('manage-pharmacy.users.activity');
        });
    });


require __DIR__.'/auth.php';
