/// scrP2DrawInteractionArrow(x, y)
draw_sprite_ext_outline(
    sP2InteractionArrow,
    (get_timer() / 100000) % sprite_get_number(sP2InteractionArrow),
    argument0 - view_xview,
    argument1 - view_yview,
    1, 1, 0, c_white, 1, 1, c_black);
