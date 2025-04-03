///draw_text_outline(xx, yy, str, col, off);

var xx = argument0;
var yy = argument1;
var str = argument2;
var col = argument3;
var off = argument4;

var c = draw_get_color()
draw_set_color(col)
draw_text(xx + off, yy + off, str)
draw_text(xx - off, yy + off, str)
draw_text(xx - off, yy - off, str)
draw_text(xx + off, yy - off, str)
draw_set_color(c)
draw_text(xx, yy, str)
