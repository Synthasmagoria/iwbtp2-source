/// scrP2TriggerEvent_OOB_BottomMiddle_Unblock
var _blockage_instances = scrP2InstanceGetTagged(oP2Corruption, "corruption blockage");
for (var i = ds_list_size(_blockage_instances) - 1; i >= 0; i--) {
    instance_destroy(_blockage_instances[|i]);
}
with (instance_create(0, 0, objP2WrapIndicator)) {
    event_user(0);
}
ds_list_destroy(_blockage_instances);
