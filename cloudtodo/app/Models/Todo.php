<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Todo extends Model
{
    use HasFactory, HasUuids;

    public $table = 'todos';
    public $incrementing = false;
    public $keyType = 'string';

    protected $fillable = [
        'title',
        'description',
        'completed',
    ];
}
