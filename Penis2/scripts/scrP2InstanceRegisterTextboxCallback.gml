/// scrP2InstanceRegisterTextboxCallback(inst, line_index, script)
var inst = argument0, line_index = argument1, script = argument2;
ds_list_add(inst.textbox_callback_script_lines, line_index);
ds_list_add(inst.textbox_callback_scripts, script);
