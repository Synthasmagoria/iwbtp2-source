/// instance_center_to_bbox_right(inst)
if (argument0.mask_index != -1)
    return (sprite_get_bbox_right(argument0.mask_index) - sprite_get_xoffset(argument0.mask_index)) * argument0.image_xscale;
else
    return (sprite_get_bbox_right(argument0.sprite_index) - sprite_get_xoffset(argument0.sprite_index)) * argument0.image_xscale;
