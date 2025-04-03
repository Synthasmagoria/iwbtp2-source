/// ds_list_append_array
var list = argument0, arr = argument1;
for (var i = 0, n = array_length_1d(arr); i < n; i++) {
    ds_list_add(list, arr[i]);
}
