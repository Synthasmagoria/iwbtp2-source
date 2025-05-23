/// scrP2HudSetScale
var scale = argument0;
with (oP2Hud) {
    hud_scale_index = scale;
    TweenFireTo(map_instance, EaseOutQuad, 0, true, 0, hud_scale_duration, "width", map_widths[hud_scale_index]);
    TweenFireTo(map_instance, EaseOutQuad, 0, true, 0, hud_scale_duration, "height", map_heights[hud_scale_index]);
    map_instance.target_width = map_widths[hud_scale_index];
    map_instance.target_height = map_heights[hud_scale_index];
    TweenFireTo(inventory_instance, EaseOutQuad, 0, true, 0, hud_scale_duration, "size", inventory_slot_sizes[hud_scale_index]);
    
    switch (hud_scale_index) {
        case P2_HUD_SCALE.MINIMIZED:
        map_instance.draw_mode = P2_MAP_DRAW_MODE.HINT;
        TweenFireTo(map_instance, EaseOutQuad, 0, true, 0, map_fade_duration, "image_alpha", 1.0);
        inventory_instance.minimized = true;
        break;
        
        case P2_HUD_SCALE.NORMAL:
        map_instance.draw_mode = P2_MAP_DRAW_MODE.MAP;
        var _r = scrSynthMapRoomGetByName(map_instance.current_room);
        if (_r != -1) {
            scrSynthMapRoomFocus(_r, false);
        }
        _in_map_area = false;
        inventory_instance.minimized = false;
        break;
        
        case P2_HUD_SCALE.MAXIMIZED:
        map_instance.draw_mode = P2_MAP_DRAW_MODE.MAP;
        var _r = scrSynthMapRoomGetByName(map_instance.current_room);
        if (_r != -1) {
            scrSynthMapRoomFocus(_r, false);
        }
        TweenFireTo(map_instance, EaseOutQuad, 0, true, 0, map_fade_duration, "image_alpha", 1.0);
        inventory_instance.minimized = false;
        break;
    }
}
