/// scrP2TilemapRoomGetFromIndex->ds_map
gml_pragma("forceinline");
return ds_list_find_value(ds_map_find_value(global.__p2_room_tiles, room_get_name(room)), argument0);
