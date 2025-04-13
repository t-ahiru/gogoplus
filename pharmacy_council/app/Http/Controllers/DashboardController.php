<?php

namespace App\Http\Controllers;

use App\Models\Pharmacy;
use App\Models\User;
use App\Models\ActivityLog;

class DashboardController extends Controller
{
    public function index()
    {
        return view('dashboard', [
            'pharmaciesCount' => Pharmacy::count(),
            'usersCount' => User::count(),
            'activitiesCount' => ActivityLog::count(),
            'recentActivities' => ActivityLog::with('user')
                ->latest()
                ->take(5)
                ->get()
        ]);
    }
}