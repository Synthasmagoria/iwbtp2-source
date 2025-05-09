/// scrP2RoomStart(xx, yy)
var xx = argument0, yy = argument1;

global.__p2_current_room_x = xx;
global.__p2_current_room_y = yy;

// TODO: Check if currently in the room in order to scan it or for gameplay
// TODO: Change level to location
if (instance_exists(oP2DataCollector)) {
    return undefined;
}

if (!instance_exists(oP2World)) {
    instance_create(0, 0, oP2World);
    return undefined;
}

if (srcP2WorldRoomIsOOB(room)) {
    global.p2Flag = int_truth_bit(global.p2Flag, P2_FLAG.OOB_DISCOVERED);
    global.saveP2Flag = int_truth_bit(global.saveP2Flag, P2_FLAG.OOB_DISCOVERED);
}

background_color = make_color_rgb(10, 10, 10);

with (oP2Hud) {
    visible = true;
}

var _world_y_border, _room_y2 = global.__p2_current_room_y + floor(room_height / view_hview[0]);
if (global.__p2_current_room_x < 7) {
    _world_y_border = 6;
} else {
    _world_y_border = 3;
}
if (global.__p2_current_room_y < _world_y_border && _room_y2 >= _world_y_border) {
    var _world_border = instance_create(0, (_world_y_border - global.__p2_current_room_y) * view_hview[0] - 200, objBrokenMegamanOcean);
    if (global.__p2_current_room_x == 7) {
        _world_border.dip = 0.461;
    }
}

var _tilemap_blocker = instance_create(0, 0, oP2TilemapBlocker);
if (_room_y2 == _world_y_border) {
    _tilemap_blocker.outside_tiles_bottom = false;
}

if (room != rP2Nuclear &&
    room != rP2IntroPonycutz &&
    int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_TALKED) &&
    !int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_GONE)) {
    if (random(1) <= 0.02) {
        global.p2Flag = int_truth_bit(global.p2Flag, P2_FLAG.TRAVELER_GONE);
        global.saveP2Flag = int_truth_bit(global.saveP2Flag, P2_FLAG.TRAVELER_GONE);
        scrP2WorldDelayedExecution(random(4), scrP2TravelerEvent_Leaving);
    }
}

if (yy == 0) {
    with (instance_create(0, 0, objPonycutzTransmissionLines)) {
        if (xx != 1) {
            offset = -room_width - 800;
            image_alpha = 0.5;
        }
    }
}

instance_create(0, 0, objP2PushOutBlockManager);

with (oP2Map) {
    draw_map_data = true;
    sh_col_a_r = 0;
    sh_col_a_g = 135 / 255;
    sh_col_a_b = 242 / 255;
    sh_col_a_a = 0.5;
    sh_col_b_r = 183 / 255;
    sh_col_b_g = 0;
    sh_col_b_b = 205 / 255;
    sh_col_b_a = 0.5;
}

var _room = scrSynthMapRoom(room_get_name(room), xx * 800, yy * 608, room_width, room_height);
scrSynthMapRoomSetCurrent(_room);
scrSynthMapRoomFocus(_room, false);

var _slug_spawner = instance_create(0, 0, objP2CorruptionSlugSpawner);

var _light_manager = instance_create(0, 0, oP2LightManager);
_light_manager.image_alpha = min(global.__p2_current_room_y * 0.1, 0.3);
instance_create(0, 0, oP2LightBig);

instance_create(0, 0, oP2Camera);

var _gravity_setter = instance_create(0, 0, oP2GravitySetter);
_gravity_setter.grav = 0.4;
instance_set_width(_gravity_setter, room_width);
instance_set_height(_gravity_setter, room_height);

var _level = clamp(xx + yy, 0, 12);
switch (room) {
    case rP2WrenchTutorial:
        if (room == rP2WrenchTutorial) {
            instance_create(0, 0, oP2BackgroundAlternative);
        }
        _slug_spawner.likelihood = 0.0;
        _tilemap_blocker.outside_tiles_right = false;
        _tilemap_blocker.outside_tiles_left = false;
        _tilemap_blocker.outside_tiles_top = false;
        _tilemap_blocker.outside_tiles_bottom = false;
        break;
    
    case rP2Intro08:
        instance_create(0, 0, objP2BrokenBackground);
        
        _slug_spawner.likelihood = 0;
        _slug_spawner.active = false;
        
        _tilemap_blocker.simple_tiles_only = true;
        _tilemap_blocker.outside_tiles_right = false;
        _tilemap_blocker.outside_tiles_left = false;
        _tilemap_blocker.outside_tiles_top = false;
        _tilemap_blocker.outside_tiles_bottom = false;
        
        _gravity_setter.grav = 0.1;
        
        instance_create(0, 0, objP2CorruptionParticleManager);
        instance_create(0, 0, objP2CorruptionParticleSpawner);
        break;
    default:
        // TODO: Create corrupted sea when room touches world bottom
        var _bg = instance_create(0, 0, oP2Background);
        _bg.image_xscale = 2;
        _bg.image_yscale = 2;
        _bg.image_speed = 0;
        _bg.level = _level;
        
        if (int_get_bit(global.p2Item, P2_ITEM.WRENCH)) {
            _bg.image_index = 1;
        }
        
        if (srcP2WorldRoomIsOOB(room)) {
            if (room == rP2SlugTilingTest_0 || room == rP2SlugTilingTest_1 || room == rP2SlugTilingTest_2) {
                background_index[0] = bP2Forest_Gray;
                background_visible[0] = true;
            }
            _bg.image_index = 2;
            if (!instance_exists(objP2DigitalLightningSurface))
                instance_create(0, 0, objP2DigitalLightningSurface);
            if (!instance_exists(objP2DigitalLightningSpawner))
                instance_create(0, 0, objP2DigitalLightningSpawner);
        }
        
        with (_bg) {
            event_user(0);
        }
        if (room != rP2Intro01) {
            var _slug_likelihood = array(0.000, 0.000, 0.005, 0.008, 0.012, 0.02, 0.03, 0.4, 0.52, 0.64, 0.8, 0.96, 1.12, 1.2, 1.3, 1.4, 1.5);
            _slug_spawner.likelihood = _slug_likelihood[clamp(_level, 0, array_length_1d(_slug_likelihood))];
        } else {
            _slug_spawner.likelihood = 0.0;
        }
        break;
}
