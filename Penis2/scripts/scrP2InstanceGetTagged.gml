/// scrP2InstanceGetTagged
var obj = argument0, tag = argument1;
var _inst = ds_list_create();
with (obj) {
    if (variable_instance_get(id, "__p2_tag") == tag) {
        ds_list_add(_inst, id);
    }
}
return _inst;
