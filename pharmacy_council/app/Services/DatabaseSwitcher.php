<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;

class DatabaseSwitcher
{
    /**
     * Switch to a pharmacy database by ID.
     *
     * @param int $pharmacyId
     * @return void
     */
    public function switchToPharmacy(int $pharmacyId): void
    {
        $databaseName = 'pharmacy' . $pharmacyId;

        // Set the dynamic database connection
        Config::set('database.connections.pharmacy_dynamic.database', $databaseName);

        // Reconnect to the new database
        DB::purge('pharmacy_dynamic');
        DB::reconnect('pharmacy_dynamic');
    }

    /**
     * Switch back to the main database.
     *
     * @return void
     */
    public function switchToMain(): void
    {
        // Reconnect to the main database
        DB::purge('pharmacy_main');
        DB::reconnect('pharmacy_main');
    }
}