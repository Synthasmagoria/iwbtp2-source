/// scrP2TilemapGetInRoom(x, y)->ds_map
//TODO: Rename to scrP2TilemapGetRoomRelative
var _td = ds_grid_get(
    global.__p2_tilemap,
    argument0 + global.__p2_current_room_x * 25,
    argument1 + global.__p2_current_room_y * 19);
if (_td == undefined)
    return -1;
return _td;
