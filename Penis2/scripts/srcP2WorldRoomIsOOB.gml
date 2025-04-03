/// srcP2WorldRoomIsOOB
var r = argument0;
var _oob = false;
with (oP2World) {
    for (var i = 0, n = ds_list_size(oob_room_list); i < n; i++) {
        _oob |= (r == oob_room_list[|i]);
    }
}
return _oob;
