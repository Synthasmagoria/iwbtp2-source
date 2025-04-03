/// scrP2TileRoomUpdateAt
var xx = argument0, yy = argument1, pipe_47_tileset = argument2;
var
_td = scrP2TilemapGetInRoom(xx, yy),
_ts = __P2_TILE_SIZE,
_tw = background_get_width(tPenis2Tileset) / _ts;

if (_td != -1 && _td[?"corruption"] != 1) {
    _td[?"pipe_tile_index"] = scrP2TilemapGetWallBitsAt(xx, yy);
    
    if (tile_exists(_td[?"tile"])) {
        tile_set_region(_td[?"tile"], (_td[?"tile_index"] % _tw) * _ts, floor(_td[?"tile_index"] / _tw) * _ts, _ts, _ts);
        var _pipe_47_tile = pipe_47_tileset[|_td[?"pipe_tile_index"]];
        tile_set_region(_td[?"pipe_tile"], _pipe_47_tile[?"left"], _pipe_47_tile[?"top"], _ts, _ts);
    }
    
    scrP2WallDestroyBlocks(_td[?"block_list"]);
    scrP2WallCreateBlocks(_td[?"pipe_tile_index"], xx * _ts, yy * _ts, _td[?"block_list"]);
}
