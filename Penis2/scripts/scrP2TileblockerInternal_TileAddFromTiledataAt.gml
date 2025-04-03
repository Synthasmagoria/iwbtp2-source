/// scrP2TileblockerInternal_TileAddFromTiledataAt(td, xx, yy, pipe_47_tileset)
var td = argument0, xx = argument1, yy = argument2, pipe_47_tileset = argument3;
if (td[?"corruption"]) {
    with (instance_create(td[?"tile_x"], td[?"tile_y"], oP2Corruption)) {
        depth = -1000000;
    }
} else {
    td[?"tile"] = tile_add(
        tPenis2Tileset,
        (td[?"tile_index"] % tileset_width) * __P2_TILE_SIZE,
        floor(td[?"tile_index"] / tileset_width) * __P2_TILE_SIZE,
        __P2_TILE_SIZE,
        __P2_TILE_SIZE,
        xx,
        yy,
        tile_depth);
    
    var _47_tile = pipe_47_tileset[|td[?"pipe_tile_index"]];
    if (is_undefined(_47_tile)) {
        print("Missing pipe tile with index: " + string(td[?"pipe_tile_index"]));
    } else {
        td[?"pipe_tile"] = tile_add(
            tP2Pipes_47,
            _47_tile[?"left"],
            _47_tile[?"top"],
            __P2_TILE_SIZE,
            __P2_TILE_SIZE,
            xx,
            yy,
            pipes_tile_depth);
    }
    
    if (!int_get_bit(global.p2Item, P2_ITEM.WRENCH)) {
        instance_create(xx, yy, objBlock);
    } else {
        scrP2WallCreateBlocks(
            scrP2TilemapGetWallBitsAt(xx / __P2_TILE_SIZE, yy / __P2_TILE_SIZE),
            xx,
            yy,
            td[?"block_list"]);
    }
}
