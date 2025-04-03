/// scrP2MainTilesetGetTileType
var index = argument0;
gml_pragma("forceinline");
return floor(index / floor(background_get_width(tPenis2Tileset) / __P2_TILE_SIZE));
