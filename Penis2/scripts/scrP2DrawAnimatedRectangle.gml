/// scrP2DrawAnimatedRectangle(xx, yy, w, h, anim)
var xx = argument0, yy = argument1, w = argument2, h = argument3, anim = argument4;
var
_x2 = xx + w,
_y2 = yy + h;
draw_line(xx, yy, xx + w * anim, yy);
draw_line(_x2, yy, _x2, yy + h * anim);
draw_line(_x2, _y2, xx + w - w * anim, _y2);
draw_line(xx, yy + h, xx, yy + h - h * anim);
