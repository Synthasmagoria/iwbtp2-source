/// scrP2InventoryItemCreate(ind, name, spr, xoff, yoff, scr, hold, usage_condition, usage_button)
var ind = argument0, name = argument1, spr = argument2, xoff = argument3, yoff = argument4, scr = argument5, hold = argument6, usage_condition = argument7, usage_button = argument8;
var _item = ds_map_create();
_item[?"slot_index"] = ind;
_item[?"name"] = name;
_item[?"sprite_index"] = spr;
_item[?"sprite_xoffset"] = xoff;
_item[?"sprite_yoffset"] = yoff;
_item[?"action_script"] = scr;
_item[?"hold_duration"] = hold;
_item[?"usage_condition"] = usage_condition;
_item[?"usage_button"] = usage_button;

_item[?"_input_indicator_alpha"] = 0.0;
_item[?"_hold"] = 0.0;
_item[?"_just_used"] = false;
return _item;
