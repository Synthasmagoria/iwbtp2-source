/// scrP2SpawnCorruptionSlug(xx, yy, xdir, ydir, pos_wrap, obj)
var xx = argument0, yy = argument1, xdir = argument2, ydir = argument3, pos_wrap = argument4, obj = argument5;

var _slug = instance_create(xx, yy, obj);
_slug.movement_pattern_x = array(xdir, xdir, xdir);
_slug.movement_pattern_y = array(0, 0, ydir);
_slug.roomwrap = pos_wrap;

with (_slug) {
    event_user(0);
}
