/// scrP2WorldCollectData
var load_file = argument0;
with (oP2World) {
    var _data_collector = instance_create(0, 0, oP2DataCollector);
    _data_collector.tile_depth = 1000000;
    _data_collector.tileset = tPenis2Tileset;
    _data_collector.world_width = 12;
    _data_collector.world_height = 6;
    _data_collector.load_file = load_file;
    ds_list_copy(_data_collector.room_list, gameplay_room_list);
    with (_data_collector)
        event_user(0);
}
