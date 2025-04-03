#define scrSynthIterMap
/// scrSynthDsUtil
return undefined;

#define scrSynthIterMapCreate
/// scrSynthIterMapCreate()->ds_map
/*
    The "iter map" scripts are ds_map function wrappers that work with an additional
    list inside of the map containing the keys
    ds_map_destroy() can be called normally on "iter maps"
*/
var _map = ds_map_create();
ds_map_add_list(_map, "__keys", ds_list_create());
return _map;

#define scrSynthIterMapAdd
/// scrSynthIterMapAdd(map, key, val)
var map = argument0, key = argument1, val = argument2;
if (is_undefined(ds_map_find_value(map, key)))
    ds_list_add(ds_map_find_value(map, "__keys"), key);
ds_map_add(map, key, val);

#define scrSynthIterMapAddList
/// scrSynthIterMapAddList(map, key, list)
var map = argument0, key = argument1, list = argument2;
if (is_undefined(ds_map_find_value(map, key)))
    ds_list_add(ds_map_find_value(map, "__keys"), key);
ds_map_add_list(map, key, list);

#define scrSynthIterMapAddMap
/// scrSynthIterMapAddMap(src_map, key, map)
var src_map = argument0, key = argument1, map = argument2;
if (is_undefined(ds_map_find_value(src_map, key)))
    ds_list_add(ds_map_find_value(src_map, "__keys"), key);
ds_map_add_map(src_map, key, map);

#define scrSynthIterMapClear
var map = argument[0]
ds_map_clear(map);
ds_map_add_list(map, "__keys", ds_list_create());

#define scrSynthIterMapGetKeys
/// scrSynthIterMapGetKeys(map)->ds_list
var map = argument0;
return map[?"__keys"];