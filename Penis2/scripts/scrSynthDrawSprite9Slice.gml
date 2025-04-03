/// scrSynthDrawSprite9Slice(spr, xx, yy, w, h)

var
_sw = sprite_get_width(spr),
_sh = sprite_get_height(spr),
spr = argument0, 
xx = argument1, 
yy = argument2, 
w = argument3, 
h = argument4

draw_sprite(spr, 0, xx, yy);
draw_sprite(spr, 2, xx + w - _sw, yy);
draw_sprite(spr, 6, xx, yy + h - _sh);
draw_sprite(spr, 8, xx + w - _sw, yy + h - _sh);

for (var xxx = xx + _sw; xxx < xx + w - _sw; xxx += _sw) {
    draw_sprite(spr, 1, xxx, yy);
    draw_sprite(spr, 7, xxx, yy + h - _sh);
}

for (var xxx = xx + _sw; xxx < xx + w - _sw; xxx += _sw) {
    for (var yyy = yy + _sh; yyy < yy + h - _sh; yyy += _sh) {
        draw_sprite(spr, 4, xxx, yyy);
    }
}

for (var yyy = yy + _sh; yyy < yy + h - _sh; yyy += _sh) {
    draw_sprite(spr, 3, xx, yyy);
    draw_sprite(spr, 5, xx + w - _sw, yyy);
}
