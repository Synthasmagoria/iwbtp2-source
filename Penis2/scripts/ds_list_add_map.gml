/// ds_list_add_map(list, map)
var list = argument0, map = argument1;
ds_list_add(list, map);
ds_list_mark_as_map(list, ds_list_size(list) - 1);
