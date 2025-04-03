///draw_sprite_ext_outline(spr, img, xx, yy, xscl, yscl, rot, blend, a, off, oblend);

var spr = argument0;
var img = argument1;
var xx = argument2;
var yy = argument3;
var xscl = argument4;
var yscl = argument5;
var rot = argument6;
var blend = argument7;
var a = argument8;
var off = argument9;
var oblend = argument10;

draw_sprite_ext(spr, img, xx + off, yy + off, xscl, yscl, rot, oblend, a)
draw_sprite_ext(spr, img, xx + off, yy - off, xscl, yscl, rot, oblend, a)
draw_sprite_ext(spr, img, xx - off, yy + off, xscl, yscl, rot, oblend, a)
draw_sprite_ext(spr, img, xx - off, yy - off, xscl, yscl, rot, oblend, a)
draw_sprite_ext(spr, img, xx, yy, xscl, yscl, rot, blend, a)
