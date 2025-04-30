<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DataRequestController;

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/data-requests/{id}/response', [DataRequestController::class, 'receiveResponse'])->name('api.data_requests.response');
});