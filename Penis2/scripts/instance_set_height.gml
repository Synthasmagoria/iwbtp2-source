///@desc Sets the height of an instance given it has a sprite
///@func instance_set_height(inst, h)
///@arg inst
///@arg h

argument[0].image_yscale = argument[1] / sprite_get_height(argument[0].sprite_index);
