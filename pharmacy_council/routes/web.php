<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\PharmacyController;
use App\Http\Controllers\DataRequestController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CouncilUserController;
use App\Http\Controllers\DrugSearchController;
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

        // Drug Search Route
    Route::get('/drugs/search', [DrugSearchController::class, 'search'])->name('drug_search.search');
    Route::get('/drugs/search/history', [DrugSearchController::class, 'history'])->name('drug_search.history');
    Route::post('/drugs/search/history/clear', [DrugSearchController::class, 'clearHistory'])->name('drug_search.clear_history');
    Route::get('/drugs/details/{product_id}/{pharmacy_id}', [DrugSearchController::class, 'details'])->name('drug_search.details');

            //Data Requests 
            Route::get('/data-requests/create', [DataRequestController::class, 'create'])->name('data_requests.create')->middleware('auth');
Route::post('/data-requests', [DataRequestController::class, 'sendRequest'])->name('data_requests.store')->middleware('auth');
Route::get('/data-requests', [DataRequestController::class, 'index'])->name('data_requests.index')->middleware('auth');
Route::get('/data-requests/{id}/share', [DataRequestController::class, 'shareForm'])->name('data_requests.share.form')->middleware('auth');
Route::post('/data-requests/{id}/share', [DataRequestController::class, 'share'])->name('data_requests.share')->middleware('auth');
Route::get('/shared-data-requests', [DataRequestController::class, 'shared'])->name('data_requests.shared')->middleware('auth');

Route::get('/notifications', function () {
    return view('notifications');
})->name('notifications')->middleware('auth');

Route::post('/notifications/{id}/mark-as-read', function ($id) {
    auth()->user()->notifications()->findOrFail($id)->markAsRead();
    return redirect()->back()->with('success', 'Notification marked as read.');
})->name('notifications.mark-as-read')->middleware('auth');

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
