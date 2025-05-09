#define scrP2TextboxScripts
/// scrP2TextboxScripts
return undefined;

#define scrP2TextboxIsLastLine
/// scrP2TextboxIsLastLine
var textbox = argument0;
return textbox.text_index + 1 >= ds_list_size(textbox.text_cut);

#define scrP2TextboxTypewriterFinished
/// scrP2TextboxTypewriterFinished
var textbox = argument0;
return !(textbox.text_char_index < string_length(textbox.text_cut[|textbox.text_index]));

#define scrP2TextboxDestroyOptions
var textbox = argument0;
instance_destroy(textbox.options_inst);

#define scrP2TextboxCreateOptions
/// scrP2TextboxCreateOptions
var textbox_inst = argument0, option_strings = argument1;

var _inst = instance_create(0, 0, objP2Options);
_inst.options = option_strings;
with (_inst) {
    event_user(0);
}

_inst.x = textbox_inst.bbox_right - _inst.sprite_width;
if (textbox_inst.y < view_hport[0]) {
    _inst.y = textbox_inst.bbox_bottom + textbox_inst.element_margin;
} else {
    _inst.y = textbox_inst.bbox_top - _inst.sprite_height - textbox_inst.element_margin;
}

if (instance_exists(textbox_inst.portrait_inst)) {
    textbox_inst.portrait_inst.visible = false;
}

textbox_inst.options_inst = _inst;

return _inst;

#define scrP2TextboxAdvance
/// scrP2TextboxAdvance
var inst = argument0;
with (inst) {
    if (!scrP2TextboxTypewriterFinished(inst)) {
        text_char_index = string_length(text_cut[|text_index]);
        if (!audio_is_playing(sound_inst)) {
            sound_inst = audio_play_sound(sound, 0, false);
            audio_sound_pitch(sound_inst, random_range(0.95, 1.05));
        }
        event_user(1);
    } else if (text_index + 1 < ds_list_size(text_cut)) {
        text_index++;
        text_char_index = 0;
        if (instance_exists(portrait_inst)) {
            portrait_inst.emotion = portrait_emotions[text_index];
        }
    } else {
        instance_destroy();
    }
}

#define scrP2TextboxCreatePortrait
var textbox = argument0, spr = argument1, emotions = argument2;
with (textbox) {
    var _inst;
    if (y < view_hport[0] / 2) {
        _inst = instance_create(x, y + sprite_height + element_margin, oP2TextboxPortrait);
    } else {
        _inst = instance_create(
            x,
            y - sprite_get_height(object_get_sprite(oP2TextboxPortrait)) - element_margin,
            oP2TextboxPortrait);
    }
    
    _inst.portrait = spr;
    portrait_emotions = emotions;
    return _inst;
}

return -1;

#define scrP2TextboxCreate
/// scrP2TextboxCreate(text, [portrait], [portrait_emotions], [text_speed], [scripts], [script_lines])->inst
var text_arr = argument[0];

with (instance_create(0, 0, oP2Textbox))
{
    text = text_arr;
    if (argument_count > 2 && argument[1] != -1) {
        portrait_sprite = argument[1];
        portrait_emotions = argument[2];
    }
    if (argument_count > 3) {
        text_speed = argument[3];
    }
    if (argument_count == 6) {
        if (is_array(argument[4])) {
            ds_list_append_array(callback_scripts, argument[4]);
        } else {
            ds_list_copy(callback_scripts, argument[4]);
        }
        
        if (is_array(argument[5])) {
            ds_list_append_array(callback_script_lines, argument[5]);
        } else {
            ds_list_copy(callback_script_lines, argument[5]);
        }
    }
    event_user(0); //init
    return id;
}
return undefined;

#define scrP2TextboxAddCallback
var textbox = argument0, line = argument1, script = argument2;
/*
    line = 0 - script gets called at the end of line 0
    line = 9999 - script gets called when the textbox is destroyed
*/
ds_list_add(textbox.callback_scripts, script);
ds_list_add(textbox.callback_script_lines, line);

#define scrP2TextboxClearCallbacks
var textbox = argument0;
ds_list_clear(textbox.callback_script_lines);
ds_list_clear(textbox.callback_scripts);