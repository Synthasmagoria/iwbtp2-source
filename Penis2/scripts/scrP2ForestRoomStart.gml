/// scrP2ForestRoomStart
if (instance_exists(oP2DataCollector))
    return undefined;

if (!instance_exists(oP2World)) {
    instance_create(0, 0, oP2World);
    return undefined;
}

instance_create(0, 0, objP2ForestSpawner);
instance_create(0, 0, objP2ForestDistanceMeasurement);
instance_create(0, 0, objP2ForestVoid);
instance_create(0, 0, objP2ForestSounds);
instance_create(0, 0, objP2ForestBackgroundFader);
instance_create(0, 0, objP2ForestParticles);

var _camera = instance_create(0, 0, objP2ForestSmoothCamera);

var _world = instance_find(oP2World, 0);

var
_bg,
_hs = array(0.0, 0.0, -1.0, 0.0, -1.5, 0.0),
_scl = array(1.0, 2.0, 1.0, 1.5, 1.0, 1.0),
_para = array(true, true, true, true, true, true),
_para_x = array(0.0, 0.08, 0.13, 0.18, 0.23, 0.27),
_para_y = array(0.0, 0.1, 0.0, 0.2, 0.0, 0.3),
_xoff = array(0, 200, irandom(background_get_width(bP2ForestLight)), 400, irandom(background_get_width(bP2ForestFgLight)), 600),
_col = array(c_white, make_color_rgb(100, 100, 100), c_white, make_color_rgb(192, 192, 192), c_white, c_white),
_abs_scl;

switch (room) {
    case rP2ForestHallucination_Autumn:
    _bg = array(bP2ForestGradient, bP2Forest_Autumn, bP2ForestLight, bP2Forest_Autumn, bP2ForestFgLight, bP2Forest_Autumn);
    break;
    
    case rP2ForestHallucination_Winter:
    _bg = array(bP2ForestGradient, bP2Forest_Winter, bP2ForestLight, bP2Forest_Winter, bP2ForestFgLight, bP2Forest_Winter);
    break;
    
    default:
    _bg = array(bP2ForestGradient, bP2Forest, bP2ForestLight, bP2Forest, bP2ForestFgLight, bP2Forest);
    break;
}

for (var i = array_length_1d(_bg) - 1; i >= 0; i--) {
    background_index[i] = _bg[i];
    background_xscale[i] = _scl[i];
    background_yscale[i] = abs(_scl[i]);
    background_hspeed[i] = _hs[i];
    background_visible[i] = true;
    background_htiled[i] = true;
    background_vtiled[i] = false;
    background_blend[i] = _col[i];
    
    with (instance_create(0, 0, objP2BackgroundParalax)) {
        index = i;
        paralax_x = _para_x[i];
        paralax_y = _para_y[i];
        xoffset = _xoff[i];
    }
}

scrP2WorldDelayedExecution(4.0, scrP2UnfreezePlayer);

switch (room) {
    case rP2ForestHallucination:
    case rP2ForestHallucination_Autumn:
    case rP2ForestHallucination_Winter:
    instance_create(0, 0, objP2ForestHallucinationStaticOverlay);
    _camera.fast_pan_in = true;
    instance_create(0, 0, objP2WrapIndicator);
    
    if (room == rP2ForestHallucination) {
        var _return = instance_create(0, 0, objP2ForestHallucinationReturnCountdown);
        _return.return_x = 320;
        _return.return_y = 256 - 16;
        _return.return_room = rP2WrenchTutorial;
        _return.return_room_song = musP2WrenchTutorial;
        
        with (oP2Map) {
            draw_map_data = false;
            current_room = "Relief?";
            sh_col_a_r = 0;
            sh_col_a_g = 242 / 255;
            sh_col_a_b = 100 / 255;
            sh_col_a_a = 0.5;
            sh_col_b_r = 0;
            sh_col_b_g = 205 / 255;
            sh_col_b_b = 183 / 255;
            sh_col_b_a = 0.5;
        }
    } else if (room == rP2ForestHallucination_Autumn) {
        var _return = instance_create(0, 0, objP2ForestHallucinationReturnCountdown);
        _return.return_x = 1072;
        _return.return_y = 208;
        _return.return_room = rP2IntroOOB_BottomMiddle_1;
        _return.return_room_song = musP2Loop2B;
        
        with (oP2Map) {
            draw_map_data = false;
            current_room = "Relief?";
            sh_col_a_r = 251 / 255;
            sh_col_a_g = 242 / 255;
            sh_col_a_b = 54 / 255;
            sh_col_a_a = 0.5;
            sh_col_b_r = 194 / 255;
            sh_col_b_g = 32 / 255;
            sh_col_b_b = 0;
            sh_col_b_a = 0.5;
        }
        with (objP2LeafBlock) {
            sprite_index = sprP2LeafTile_Yellow;
            part_type = 1;
        }
    } else if (room == rP2ForestHallucination_Winter) {
        var _return = instance_create(0, 0, objP2ForestHallucinationReturnCountdown);
        _return.return_x = 680;
        _return.return_y = 800;
        _return.return_room = rP2Intro07;
        _return.return_room_song = musP2Loop2A;
        
        with (oP2Map) {
            draw_map_data = false;
            current_room = "Relief?";
            sh_col_a_r = 199 / 255;
            sh_col_a_g = 236 / 255;
            sh_col_a_b = 236 / 255;
            sh_col_a_a = 0.5;
            sh_col_b_r = 0;
            sh_col_b_g = 208 / 255;
            sh_col_b_b = 208 / 255;
            sh_col_b_a = 0.5;
        }
        with (objP2LeafBlock) {
            sprite_index = sprP2LeafTile_White;
            part_type = 2;
        }
    }
    
    
    break;
    
    default:
    with (oP2Hud) visible = false;
    break;
}
