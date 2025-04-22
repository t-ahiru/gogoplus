<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('pharmacies', function (Blueprint $table) {
            // Add API-related fields if they don't exist
            if (!Schema::hasColumn('pharmacies', 'api_endpoint')) {
                $table->string('api_endpoint')->nullable()->after('database_connection');
            }
            if (!Schema::hasColumn('pharmacies', 'api_key')) {
                $table->string('api_key')->nullable()->after('api_endpoint');
            }
            if (!Schema::hasColumn('pharmacies', 'api_status')) {
                $table->string('api_status')->default('unknown')->after('api_key');
            }
            if (!Schema::hasColumn('pharmacies', 'last_api_request_at')) {
                $table->timestamp('last_api_request_at')->nullable()->after('api_status');
            }
        });
    }

    public function down(): void
    {
        Schema::table('pharmacies', function (Blueprint $table) {
            $table->dropColumn(['api_endpoint', 'api_key', 'api_status', 'last_api_request_at']);
        });
    }
};