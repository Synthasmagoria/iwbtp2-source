/// scrP2LoadData
if (file_exists(scrP2SaveDataGetName())) {
    var _perf_timer = get_timer();
    var _b = buffer_load(scrP2SaveDataGetName());
    
    print("scrP2SaveData: Read buffer (" + string(get_timer() - _perf_timer) + "ns)");
    _perf_timer = get_timer();
    
    var
    _room_number = buffer_read(_b, buffer_s32),
    _room_name, _x, _y, _w, _h;
    repeat(_room_number) {
        _room_name = buffer_read_string(_b, 32);
        _x = buffer_read(_b, buffer_s32);
        _y = buffer_read(_b, buffer_s32);
        _w = buffer_read(_b, buffer_s32);
        _h = buffer_read(_b, buffer_s32);
        scrSynthMapRoom(_room_name, _x, _y, _w, _h);
    }
    
    print("scrP2SaveData: Loaded rooms (" + string(get_timer() - _perf_timer) + "ns)");
    _perf_timer = get_timer();
    
    var
    _objective_number = buffer_read(_b, buffer_s32),
    _objective_name, _objective_room, _objective_cleared;
    repeat(_objective_number) {
        _objective_name = buffer_read_string(_b, 32);
        _objective_room = buffer_read_string(_b, 32);
        _objective_cleared = buffer_read(_b, buffer_s32);
        if (_objective_cleared) {
            scrP2ObjectiveAddCleared(_objective_name, _objective_room);
        } else {
            scrP2ObjectiveAdd(_objective_name, _objective_room);
        }
    }
    
    print("scrP2SaveData: Loaded objectives (" + string(get_timer() - _perf_timer) + "ns)");
    _perf_timer = get_timer();
    
    var
    _tile_number = buffer_read(_b, buffer_s32),
    _tile_data, _tile_room_name, _tile_world_x, _tile_world_y, _tile_x, _tile_y, _tile_index, _tile_pipe_index, _tile_corruption, _tile_map_x, _tile_map_y;
    repeat(_tile_number) {
        _tile_room_name = buffer_read_string(_b, 32);
        _tile_world_x = buffer_read(_b, buffer_s32);
        _tile_world_y = buffer_read(_b, buffer_s32);
        _tile_x = buffer_read(_b, buffer_s32);
        _tile_y = buffer_read(_b, buffer_s32);
        _tile_index = buffer_read(_b, buffer_s32);
        _tile_pipe_index = buffer_read(_b, buffer_s32);
        _tile_corruption = buffer_read(_b, buffer_s32);
        scrP2TilemapSet(
            _tile_world_x,
            _tile_world_y,
            _tile_x,
            _tile_y,
            _tile_index,
            _tile_pipe_index,
            _tile_corruption,
            _tile_room_name);
    }
     
    print("scrP2SaveData: Loaded tiles (" + string(get_timer() - _perf_timer) + "ns)");
    _perf_timer = get_timer();
    
    buffer_delete(_b);
}
