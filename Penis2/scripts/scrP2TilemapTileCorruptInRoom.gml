/// scrP2TilemapTileCorruptInRoom
var xx = argument0, yy = argument1;
var _td = scrP2TilemapGetInRoom(xx, yy);
if (!_td) {
    _td = scrP2TiledataCreate(
        xx * __P2_TILE_SIZE + global.__p2_current_room_x * 800,
        yy * __P2_TILE_SIZE + global.__p2_current_room_y * 608,
        xx * __P2_TILE_SIZE,
        yy * __P2_TILE_SIZE,
        0,
        0,
        true);
    scrP2TilemapAddTiledata(_td, room);
}
_td[?"corruption"] = true;
