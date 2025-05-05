<?php

namespace App\Observers;

use App\Models\Record;

class RecordObserver
{
    /**
     * Handle the Record "created" event.
     */
    public function created(Record $record): void
    {
        //
    }

    /**
     * Handle the Record "updated" event.
     */
    public function updated(Record $record): void
    {
        //
    }

    /**
     * Handle the Record "deleted" event.
     */
    public function deleted(Record $record): void
    {
        //
    }

    /**
     * Handle the Record "restored" event.
     */
    public function restored(Record $record): void
    {
        //
    }

    /**
     * Handle the Record "force deleted" event.
     */
    public function forceDeleted(Record $record): void
    {
        //
    }
}
