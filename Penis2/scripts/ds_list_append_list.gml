/// ds_list_append_list(list, source)
var list = argument0, source = argument1;
for (var i = 0, n = ds_list_size(source); i < n; i++) {
    ds_list_add(list, ds_list_find_value(source, i));
}
