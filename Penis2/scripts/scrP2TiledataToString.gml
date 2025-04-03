/// scrP2TiledataToString(td)
var td = argument0;

return string(td) + ": {" +
    "tile: " + string(td[?"tile"]) +
    ", tile_index: " + string(td[?"tile_index"]) +
    ", tile_x: " + string(td[?"tile_x"]) +
    ", tile_y: " + string(td[?"tile_y"]) +
    ", pipe_tile: " + string(td[?"pipe_tile"]) +
    ", pipe_tile_index: " + string(td[?"pipe_tile_index"]) + "}";
