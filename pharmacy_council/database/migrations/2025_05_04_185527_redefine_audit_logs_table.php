<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RedefineAuditLogsTable extends Migration
{
    public function up()
    {
        $pharmacyConnections = ['pharmacy1', 'pharmacy2', 'pharmacy3', 'pharmacy4', 'pharmacy5'];

        foreach ($pharmacyConnections as $connection) {
            // Drop the existing audit_logs table
            Schema::connection($connection)->dropIfExists('audit_logs');

            // Create the new audit_logs table with simplified structure
            Schema::connection($connection)->create('audit_logs', function (Blueprint $table) {
                $table->id();
                $table->unsignedBigInteger('user_id')->nullable(); // User who performed the action
                $table->string('action'); // Type of action (e.g., "created", "updated", "deleted")
                $table->text('details')->nullable(); // JSON field for action details
                $table->unsignedBigInteger('pharmacy_id')->nullable(); // Pharmacy ID (1 to 5)
                $table->unsignedBigInteger('warehouse_id')->nullable(); // Warehouse ID (if applicable)
                $table->timestamp('created_at')->useCurrent(); // Timestamp of the action
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