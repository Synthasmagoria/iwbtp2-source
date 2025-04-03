/// scrP2Tileset3x3AddTile(tileset, index, left, top)
var tileset = argument0, ind = argument1, left = argument2, top = argument3;
var _tile = ds_map_create();
_tile[?"top"] = top;
_tile[?"left"] = left;
tileset[|ind] = _tile;
ds_list_mark_as_map(tileset, ind);
