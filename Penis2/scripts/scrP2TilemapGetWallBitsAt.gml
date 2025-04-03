/// scrP2GetWallBitsAt(xx, yy)
var xx = argument0, yy = argument1;

var _td = scrP2TilemapGetInRoom(xx, yy);
if (_td != -1) {
    var
    _tile_type = scrP2MainTilesetGetTileType(_td[?"tile_index"]),
    _walls = 0;
    
    switch (_tile_type) {
    case P2_TILE_TYPE.FILLING:
        _walls = 511 ^ P2_TILING_BITS.MIDDLE;
        break;
    case P2_TILE_TYPE.BLOCK:
        var
        _adjacent_tile,
        _tx = xx * __P2_TILE_SIZE,
        _ty = yy * __P2_TILE_SIZE,
        _tdepth = 1000000;
        
        _walls = 511 ^ P2_TILING_BITS.MIDDLE;
        _adjacent_tile = scrP2TilemapGetInRoom(xx + 1, yy);
        if (_adjacent_tile != -1 && scrP2MainTilesetGetTileType(_adjacent_tile[?"tile_index"]) == P2_TILE_TYPE.HORIZONTAL)
            _walls = int_set_bit(_walls, P2_TILING_BIT_POSITIONS.RIGHT, false);
        _adjacent_tile = scrP2TilemapGetInRoom(xx, yy - 1);
        if (_adjacent_tile != -1 && scrP2MainTilesetGetTileType(_adjacent_tile[?"tile_index"]) == P2_TILE_TYPE.VERTICAL)
            _walls = int_set_bit(_walls, P2_TILING_BIT_POSITIONS.TOP, false);
        _adjacent_tile = scrP2TilemapGetInRoom(xx - 1, yy);
        if (_adjacent_tile != -1 && scrP2MainTilesetGetTileType(_adjacent_tile[?"tile_index"]) == P2_TILE_TYPE.HORIZONTAL)
            _walls = int_set_bit(_walls, P2_TILING_BIT_POSITIONS.LEFT, false);
        _adjacent_tile = scrP2TilemapGetInRoom(xx, yy + 1);
        if (_adjacent_tile != -1 && scrP2MainTilesetGetTileType(_adjacent_tile[?"tile_index"]) == P2_TILE_TYPE.VERTICAL)
            _walls = int_set_bit(_walls, P2_TILING_BIT_POSITIONS.BOTTOM, false);
        //if (_walls != 511 ^ P2_TILING_BITS.MIDDLE) {
        //    print("unconventional wall bitmask at (" + string(xx * 32) + ", " + string(yy * 32) + "):" + print_bitmask(_walls));
        //}
        break;
    case P2_TILE_TYPE.VERTICAL:
        _walls = ((511 ^ P2_TILING_BITS.TOP) ^ P2_TILING_BITS.MIDDLE) ^ P2_TILING_BITS.BOTTOM
        break;
    case P2_TILE_TYPE.HORIZONTAL:
        _walls = ((511 ^ P2_TILING_BITS.LEFT) ^ P2_TILING_BITS.MIDDLE) ^ P2_TILING_BITS.RIGHT;
        break;
}
    
    return _walls;
}

return -1;
