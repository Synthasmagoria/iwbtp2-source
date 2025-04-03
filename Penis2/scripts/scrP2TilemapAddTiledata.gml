/// scrP2TilemapAddTiledata(td, _room)
var td = argument0, _room = argument1;
var
_tx = floor(td[?"tile_x"] / 32) + global.__p2_current_room_x * 25,
_ty = floor(td[?"tile_y"] / 32) + global.__p2_current_room_y * 19;
global.__p2_tilemap[#_tx, _ty] = td;
ds_list_add_map(global.__p2_room_tiles[?room_get_name(_room)], td);
