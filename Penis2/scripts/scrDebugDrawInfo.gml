/// scrDebugDrawInfo(props)
var props = argument0;
// Draws a list of strings in a box
draw_set_font(fP2Silver16);
var
_padding = 4,
_dx = 4,
_dy = 4,
_spacing = 16,
_width = 0,
_height = _dy + 16 * array_length_1d(props) + _padding;

for (var i = 0, n = array_length_1d(props); i < n; i++)
    _width = max(string_width(props[i]), _width);
_width += _padding * 2;

draw_set_color(c_black);
draw_set_alpha(0.75);
draw_rectangle(_dx, _dy, _dx + _width, _dy + _height, false);
draw_set_color(c_white);
draw_set_alpha(1.0);
draw_rectangle(_dx, _dy, _dx + _width, _dy + _height, true);

_dx += _padding;
_dy += _padding;
for(var i = 0, n = array_length_1d(props); i < n; i++)
{
    draw_text(_dx, _dy, props[i]);
    _dy += _spacing;
}
