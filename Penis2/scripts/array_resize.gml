/// array_resize->array
var arr = argument0, size = argument1, def = argument2;
var
_len = array_length_1d(arr),
_arr;

if (_len < size) {
    _arr = arr;
    _arr[size - 1] = 0;
    for (var i = _len; i < size; i++) {
        _arr[i] = def;
    }
} else if (_len > size) {
    _arr = array_create(size);
    array_copy(_arr, 0, arr, 0, size);
} else {
    _arr = arr;
}

return _arr;

