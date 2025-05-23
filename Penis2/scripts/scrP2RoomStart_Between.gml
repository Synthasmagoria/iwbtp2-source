/// scrP2RoomStart_Between

if (instance_exists(oP2DataCollector))
    return undefined;

if (!instance_exists(oP2World)) {
    instance_create(0, 0, oP2World);
    return undefined;
}

with (oP2Hud) visible = true;

with (oP2Map) {
    draw_map_data = false;
    current_room = "Between";
    sh_col_a_r = 242 / 255;
    sh_col_a_b = 100 / 255;
    sh_col_a_g = 0;
    sh_col_a_a = 0.5;
    sh_col_b_r = 205 / 255;
    sh_col_b_g = 0;
    sh_col_b_g = 183 / 255;
    sh_col_b_a = 0.5;
}

instance_create(0, 0, objP2Between_BlockManager);

var _inst;
_inst = instance_create(0, 0, objP2RedStatic);
_inst.depth = -1000000;
_inst.image_alpha = 0.66;
_inst = instance_create(0, 0, objP2RedStatic);
_inst.depth = -1000000;
_inst.image_alpha = 0.33;
_inst.strength = 0.08;
_inst.time = 2.5;
_inst = instance_create(0, 0, objP2RedStatic);
_inst.depth = -1000000;
_inst.image_alpha = 0.33;
_inst.strength = 0.08;
_inst.time = 5;

_inst = instance_create(0, 0, objP2Between_Lines);
_inst.image_blend = make_color_rgb(200, 0, 0);
_inst.depth = -500000;

instance_create(0, 0, objSmoothCamera);
view_object[0] = objPlayer;
view_hborder[0] = 400;
view_vborder[0] = 304;

var _light_manager = instance_create(0, 0, oP2LightManager);
_light_manager.image_alpha = 0.2;
instance_create(0, 0, oP2LightBig);
