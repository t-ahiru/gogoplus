<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRecordsTable extends Migration
{
    public function up()
    {
        $pharmacyConnections = ['pharmacy1', 'pharmacy2', 'pharmacy3', 'pharmacy4', 'pharmacy5'];

        foreach ($pharmacyConnections as $connection) {
            Schema::connection($connection)->create('records', function (Blueprint $table) {
                $table->id();
                $table->string('patient_name');
                $table->string('medication');
                $table->unsignedBigInteger('pharmacy_id')->nullable();
                $table->unsignedBigInteger('warehouse_id')->nullable();
                $table->timestamps();
            });
        }
    }

    public function down()
    {
        $pharmacyConnections = ['pharmacy1', 'pharmacy2', 'pharmacy3', 'pharmacy4', 'pharmacy5'];

        foreach ($pharmacyConnections as $connection) {
            Schema::connection($connection)->dropIfExists('records');
        }
    }
}