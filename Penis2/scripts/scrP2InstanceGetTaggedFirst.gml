/// scrP2InstanceGetTaggedFirst
var obj = argument0, tag = argument1;
with (obj) {
    if (variable_instance_get(id, "__p2_tag") == tag) {
        return id;
    }
}
return noone;
