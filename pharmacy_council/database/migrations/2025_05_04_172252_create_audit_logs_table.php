<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAuditLogsTable extends Migration
{
    public function up()
    {
        $pharmacyConnections = ['pharmacy1', 'pharmacy2', 'pharmacy3', 'pharmacy4', 'pharmacy5'];

        foreach ($pharmacyConnections as $connection) {
            Schema::connection($connection)->create('audit_logs', function (Blueprint $table) {
                $table->id();
                $table->unsignedBigInteger('action_id')->nullable(); // User ID who performed the action
                $table->string('action_type'); // Type of action (e.g., "create", "edit", "delete", "login")
                $table->string('entity_type')->nullable(); // Entity type (e.g., "prescription", "record")
                $table->unsignedBigInteger('entity_id')->nullable(); // Entity ID (e.g., prescription ID)
                $table->text('payload')->nullable(); // Additional data (e.g., old/new values for edits)
                $table->string('route')->nullable(); // Route/URL of the action
                $table->unsignedBigInteger('warehouse_id')->nullable(); // Warehouse ID (if applicable)
                $table->unsignedBigInteger('pharmacy_id')->nullable(); // Pharmacy ID
                $table->timestamps();
                $table->timestamp('synced_at')->nullable(); // Sync timestamp
            });
        }
    }

    public function down()
    {
        $pharmacyConnections = ['pharmacy1', 'pharmacy2', 'pharmacy3', 'pharmacy4', 'pharmacy5'];

        foreach ($pharmacyConnections as $connection) {
            Schema::connection($connection)->dropIfExists('audit_logs');
        }
    }
}