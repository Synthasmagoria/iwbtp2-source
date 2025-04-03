///@function instance_get_middle_y(inst)
return
    (argument0.y - sprite_get_yoffset(argument0.sprite_index) * argument0.image_yscale) +
    sprite_height / 2;
