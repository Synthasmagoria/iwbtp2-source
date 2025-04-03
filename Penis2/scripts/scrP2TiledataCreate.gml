/// scrP2TiledataCreate(world_x, world_y, tile_x, tile_y, tile_index, pipe_tile_index, corruption)
var world_x = argument0, world_y = argument1, tile_x = argument2, tile_y = argument3, tile_index = argument4, pipe_tile_index = argument5, corruption = argument6;
// TODO: Some of these are used for spawning, some of these are used to keep track.
// add better categorization
var _data = ds_map_create();
_data[?"tile"] = -1;
_data[?"pipe_tile"] = -1;
ds_map_add_list(_data, "block_list", ds_list_create());

_data[?"world_x"] = world_x;
_data[?"world_y"] = world_y;
_data[?"tile_x"] = tile_x;
_data[?"tile_y"] = tile_y;
_data[?"tile_index"] = tile_index;
_data[?"pipe_tile_index"] = pipe_tile_index;
_data[?"corruption"] = corruption;

return _data;
