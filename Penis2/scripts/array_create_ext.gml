/// array_create_ext
var size = argument0, val = argument1;
var _arr = array_create(size);
for (var i = 0; i < size; i++) {
    _arr[i] = val;
}
return _arr;
