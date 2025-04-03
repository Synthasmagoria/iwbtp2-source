/// scrP2SetTiledataAt(world_x, world_y, tile_x, tile_y, tile_index, pipe_tile_index, corruption, _room_name)
var world_x = argument0, world_y = argument1, tile_x = argument2, tile_y = argument3, tile_index = argument4, pipe_tile_index = argument5, corruption = argument6, _room_name = argument7;

var
_tile_map_x = world_x / 32,
_tile_map_y = world_y / 32;

var _td = scrP2TilemapGet(_tile_map_x, _tile_map_y);
if (_td == undefined || _td == -1) {
    _td = scrP2TiledataCreate(
        world_x,
        world_y,
        tile_x,
        tile_y,
        tile_index,
        pipe_tile_index,
        corruption);
    global.__p2_tilemap[#_tile_map_x, _tile_map_y] = _td;
    ds_list_add_map(global.__p2_room_tiles[?_room_name], _td);
} else {
    _td[?"tile_index"] = tile_index;
    _td[?"pipe_tile_index"] = pipe_tile_index;
    _td[?"corruption"] = corruption;
}
