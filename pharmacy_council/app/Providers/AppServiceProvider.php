<?php

namespace App\Providers;

use App\Services\DatabaseSwitcher;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register()
    {
        $this->app->singleton(DatabaseSwitcher::class, function ($app) {
            return new DatabaseSwitcher();
        });
    }

    public function boot()
    {
        //
    }
}