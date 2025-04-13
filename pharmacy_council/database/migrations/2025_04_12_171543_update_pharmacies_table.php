<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('pharmacies', function (Blueprint $table) {
            // Add missing fields if they don't exist
            if (!Schema::hasColumn('pharmacies', 'license_number')) {
                $table->string('license_number')->unique()->after('name');
            }
            if (!Schema::hasColumn('pharmacies', 'address')) {
                $table->string('address')->after('license_number');
            }
            if (!Schema::hasColumn('pharmacies', 'location')) {
                $table->string('location')->after('address');
            }
            if (!Schema::hasColumn('pharmacies', 'contact_phone')) {
                $table->string('contact_phone')->after('location');
            }
            if (!Schema::hasColumn('pharmacies', 'contact_email')) {
                $table->string('contact_email')->after('contact_phone');
            }
            if (!Schema::hasColumn('pharmacies', 'database_connection')) {
                $table->string('database_connection')->unique()->nullable()->after('contact_email');
            }
        });
    }

    public function down(): void
    {
        Schema::table('pharmacies', function (Blueprint $table) {
            $table->dropColumn([
                'license_number',
                'address',
                'location',
                'contact_phone',
                'contact_email',
                'database_connection',
            ]);
        });
    }
};