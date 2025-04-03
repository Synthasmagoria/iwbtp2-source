/// scrP2SaveData
var
_rooms = hud_instance.map_instance.rooms,
_room_keys = scrSynthIterMapGetKeys(_rooms),
_room_number = ds_list_size(_room_keys), 
_room_data,
_room_data_total_size = _room_number * (32+4+4+4+4);

var
_objectives = hud_instance.objectives_instance.objectives,
_objectives_cleared = hud_instance.objectives_instance.cleared_objectives,
_objectives_total = ds_list_size(_objectives) + ds_list_size(_objectives_cleared),
_objective_data_total_size = (32+32+4) * (_objectives_total),
_objective;

var
_room_tiles_map = global.__p2_room_tiles,
_tile_data_total_size = 0,
_tile_number = 0;
for (var i = 0, keys = scrSynthIterMapGetKeys(_room_tiles_map), n = ds_list_size(keys); i < n; i++) {
    _tile_number += ds_list_size(_room_tiles_map[?keys[|i]]);
    _tile_data_total_size += (4+4+4+4+4+4+4+32) * ds_list_size(_room_tiles_map[?keys[|i]]);
}

var _b = buffer_create(
    _room_data_total_size + _objective_data_total_size + _tile_data_total_size + 4 * 3,
    buffer_fixed,
    4);

var _perf_timer = get_timer();

buffer_write(_b, buffer_s32, _room_number);
for (var i = 0; i < _room_number; i++) {
    _room_data = _rooms[?_room_keys[|i]];
    buffer_write_string(_b, _room_data[?"n"], 32);
    buffer_write(_b, buffer_s32, _room_data[?"x"]);
    buffer_write(_b, buffer_s32, _room_data[?"y"]);
    buffer_write(_b, buffer_s32, _room_data[?"w"]);
    buffer_write(_b, buffer_s32, _room_data[?"h"]);
}

print("scrP2SaveData: Saved rooms (" + string(get_timer() - _perf_timer) + "ns)");
_perf_timer = get_timer();

buffer_write(_b, buffer_s32, _objectives_total);
for (var i = 0, n = ds_list_size(_objectives); i < n; i++) {
    _objective = _objectives[|i];
    buffer_write_string(_b, _objective[?"name"], 32);
    buffer_write_string(_b, _objective[?"room"], 32);
    buffer_write(_b, buffer_s32, false);
}
for (var i = 0, n = ds_list_size(_objectives_cleared); i < n; i++) {
    _objective = _objectives_cleared[|i];
    buffer_write_string(_b, _objective[?"name"], 32);
    buffer_write_string(_b, _objective[?"room"], 32);
    buffer_write(_b, buffer_s32, true);
}

print("scrP2SaveData: Saved objectives (" + string(get_timer() - _perf_timer) + "ns)");
_perf_timer = get_timer();

buffer_write(_b, buffer_s32, _tile_number);
var _room_tiles_list, _td;
for (var i = 0, keys = scrSynthIterMapGetKeys(_room_tiles_map), n = ds_list_size(keys); i < n; i++) {
    _room_tiles_list = _room_tiles_map[?keys[|i]];
    for (var ii = 0, nn = ds_list_size(_room_tiles_list); ii < nn; ii++) {
        _td = _room_tiles_list[|ii];
        buffer_write_string(_b, keys[|i], 32);
        buffer_write(_b, buffer_s32, _td[?"world_x"]);
        buffer_write(_b, buffer_s32, _td[?"world_y"]);
        buffer_write(_b, buffer_s32, _td[?"tile_x"]);
        buffer_write(_b, buffer_s32, _td[?"tile_y"]);
        buffer_write(_b, buffer_s32, _td[?"tile_index"]);
        buffer_write(_b, buffer_s32, _td[?"pipe_tile_index"]);
        buffer_write(_b, buffer_s32, _td[?"corruption"]);
    }
}

print("scrP2SaveData: Saved tiles (" + string(get_timer() - _perf_timer) + "ns)");
_perf_timer = get_timer();

buffer_save(_b, scrP2SaveDataGetName());
buffer_delete(_b);

print("scrP2SaveData: Wrote buffer (" + string(get_timer() - _perf_timer) + "ns)");
