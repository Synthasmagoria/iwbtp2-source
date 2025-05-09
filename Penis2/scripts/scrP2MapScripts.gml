#define scrP2MapScripts
/// scrP2MapScripts
return undefined;

#define scrSynthMapRoom
/// scrSynthMapRoom(name, xx, yy, w, h)->ds_map
var name = argument0, xx = argument1, yy = argument2, w = argument3, h = argument4;
// TODO: Consider keeping the global save variables up to date alongside
// the optimized data structure in the map

with (oP2Map)
{
    var _room = ds_map_find_value(rooms, name);
    if (_room != undefined)
        return _room;
    
    var _room = ds_map_create();
    _room[?"x"] = xx;
    _room[?"y"] = yy;
    _room[?"w"] = w;
    _room[?"h"] = h;
    _room[?"n"] = name;
    scrSynthIterMapAddMap(rooms, name, _room);
    return _room;
}

show_error("Script was called despite there not being a map present", true);
return undefined;

#define scrSynthMapRoomSetCurrent
/// scrSynthMapRoomSetCurrent(r)
var r = argument0;
with (oP2Map)
{
    current_room = r[?"n"];
}

#define scrSynthMapRoomExists
/// scrSynthmapRoomExists(name)
var name = argument0;
with (oP2Map) {
    return !is_undefined(rooms[?name]);
}

#define scrSynthMapRoomFocus
/// scrSynthMapRoomFocus(r, snap)
var r = argument0, snap = argument1;
with (oP2Map)
{
    TweenDestroySafe(_x_tween);
    TweenDestroySafe(_y_tween);
    
    var
    _middle_x = r[?"x"] + r[?"w"] / 2 - target_width / scale / 2,
    _middle_y = r[?"y"] + r[?"h"] / 2 - target_height / scale / 2;
    
    if (snap)
    {
        cam_x = _middle_x;
        cam_y = _middle_y;
    }
    else
    {
        TweenFire(id, EaseInOutSine, TWEEN_MODE_ONCE, true, 0, 0.5, "cam_x", cam_x, _middle_x);
        TweenFire(id, EaseInOutSine, TWEEN_MODE_ONCE, true, 0, 0.5, "cam_y", cam_y, _middle_y);
    }
}

#define scrSynthMapRoomGetByName
/// scrSynthMapRoomGetByName(name)
var name = argument0;
with (oP2Map) {
    var _room = rooms[?name];
    if (!is_undefined(_room)) {
        return _room;
    }
}
return -1;

#define scrSynthMapRoomGoto
/// scrSynthMapRoomGoto(name, xx, yy, w, h, snap)
var name = argument0, xx = argument1, yy = argument2, w = argument3, h = argument4, snap = argument5;
var _room = scrSynthMapRoom(name, xx, yy, w, h);
scrSynthMapRoomSetCurrent(_room);
scrSynthMapRoomFocus(_room, snap);

#define scrSynthMapRoomSetTarget
/// scrSynthMapRoomSetTarget(name)
var name = argument0;
with (oP2Map)
{
    var _room = rooms[?name];
    if (is_undefined(_room))
    {
        objective_room = "";
        break;
    }
    
    objective_room = name;
}

#define scrSynthMapGetScreenArea
with (oP2Map)
{
    return array(view_wview[0] - padding - width, padding, view_wview[0] - padding, padding + height);
}

return undefined;