@props([
    'for',
    'value',
])

<label {{ $attributes->merge(['class' => 'block font-medium text-sm text-gray-700']) }} {{ $for ? 'for="' . $for . '"' : '' }}>
    {{ $value ?? $slot }}
</label>