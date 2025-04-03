/// ds_list_array
var list = argument0;
var _arr;
for (var i = ds_list_size(list) - 1; i >= 0; i--) {
    _arr[i] = list[|i];
}
return _arr;
