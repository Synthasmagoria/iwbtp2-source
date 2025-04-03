/// scrP2WorldCreateForestTile(x, y, left, top, bg)
var xx = argument0, yy = argument1, left = argument2, top = argument3, bg = argument4;
var _tile = forest_tile_pool[|forest_tile_pool_index];
_tile[?"x"] = xx;
_tile[?"y"] = yy;
_tile[?"left"] = left;
_tile[?"top"] = top;
_tile[?"bg"] = bg;
ds_list_add(forest_tiles, _tile);
forest_tile_pool_index = (forest_tile_pool_index + 1) % ds_list_size(forest_tile_pool);
