/// scrP2ElevatorInterraction_Open
with (objPlayer) {
    frozen = true;
}
instance_create(0, 0, objP2ElevatorBackground);
var _spr = object_get_sprite(objP2ElevatorPanel);
instance_create(
    view_wview[0] / 2 - sprite_get_width(_spr) / 2,
    view_hview[0] / 2 - sprite_get_height(_spr) / 2,
    objP2ElevatorPanel);
