///@desc Sets the width of an instance given it has a sprite
///@func instance_set_width(inst, w)
///@arg inst
///@arg w

argument[0].image_xscale = argument[1] / sprite_get_width(argument[0].sprite_index);
