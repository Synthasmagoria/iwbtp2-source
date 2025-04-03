///@function instance_get_middle_x(inst)
return
    argument0.x -
    sprite_get_xoffset(argument0.sprite_index) * argument0.image_xscale +
    sprite_width / 2;
