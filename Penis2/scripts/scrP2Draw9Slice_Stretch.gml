/// scrP2Draw9Slice_Stretch
var spr = argument0, xx = argument1, yy = argument2, w = argument3, h = argument4;
var
_sw = sprite_get_width(spr),
_sh = sprite_get_height(spr),
_middle_xscl = (w - _sw * 2) / _sw,
_middle_yscl = (h - _sh * 2) / _sh;

draw_sprite(spr, 0, xx, yy);
draw_sprite_ext(spr, 1, xx + _sw, yy, _middle_xscl, 1, 0, c_white, 1.0);
draw_sprite(spr, 2, xx + w - _sw, yy);

draw_sprite_ext(spr, 3, xx, yy + _sh, 1, _middle_yscl, 0, c_white, 1.0);
draw_sprite_ext(spr, 4, xx + _sw, yy + _sh, _middle_xscl, _middle_yscl, 0, c_white, 1.0);
draw_sprite_ext(spr, 5, xx + w - _sw, yy + _sh, 1, _middle_yscl, 0, c_white, 1.0);

draw_sprite(spr, 6, xx, yy + h - _sh);
draw_sprite_ext(spr, 7, xx + _sw, yy + h - _sh, _middle_xscl, 1, 0, c_white, 1.0);
draw_sprite(spr, 8, xx + w - _sw, yy + h - _sh);
