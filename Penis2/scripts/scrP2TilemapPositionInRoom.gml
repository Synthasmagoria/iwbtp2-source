/// scrP2TilemapPositionInRoom
var xx = argument0, yy = argument1;
return point_in_rectangle(
    xx,
    yy,
    0,
    0,
    floor(room_width / __P2_TILE_SIZE) - 1,
    floor(room_height / __P2_TILE_SIZE) - 1);
