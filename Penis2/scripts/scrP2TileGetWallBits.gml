/// scrP2TileGetWallBits(tile)
var tile = argument0;

var
_ts = tile_get_width(tile),
_tile_type = floor(tile_get_top(tile) / _ts),
_walls = 0;
    
switch (_tile_type) {
    case P2_TILE_TYPE.FILLING:
        _walls = 511 ^ P2_TILING_BITS.MIDDLE;
        break;
    case P2_TILE_TYPE.BLOCK:
        var
        _adjacent_tile,
        _tx = tile_get_x(tile),
        _ty = tile_get_y(tile),
        _td = tile_get_depth(tile);
        
        _walls = 511 ^ P2_TILING_BITS.MIDDLE;
        _adjacent_tile = tile_layer_find(_td, _tx + 32, _ty);
        if (_adjacent_tile != -1 && floor(tile_get_top(_adjacent_tile) / _ts) == P2_TILE_TYPE.HORIZONTAL)
            _walls = int_set_bit(_walls, P2_TILING_BIT_POSITIONS.RIGHT, false);
        _adjacent_tile = tile_layer_find(_td, _tx, _ty - 32);
        if (_adjacent_tile != -1 && floor(tile_get_top(_adjacent_tile) / _ts) == P2_TILE_TYPE.VERTICAL)
            _walls = int_set_bit(_walls, P2_TILING_BIT_POSITIONS.TOP, false);
        _adjacent_tile = tile_layer_find(_td, _tx - 32, _ty);
        if (_adjacent_tile != -1 && floor(tile_get_top(_adjacent_tile) / _ts) == P2_TILE_TYPE.HORIZONTAL)
            _walls = int_set_bit(_walls, P2_TILING_BIT_POSITIONS.LEFT, false);
        _adjacent_tile = tile_layer_find(_td, _tx, _ty + 32);
        if (_adjacent_tile != -1 && floor(tile_get_top(_adjacent_tile) / _ts) == P2_TILE_TYPE.VERTICAL)
            _walls = int_set_bit(_walls, P2_TILING_BIT_POSITIONS.BOTTOM, false);
        //if (_walls != 511 ^ P2_TILING_BITS.MIDDLE) {
        //    print("unconventional wall bitmask: " + print_bitmask(_walls));
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
