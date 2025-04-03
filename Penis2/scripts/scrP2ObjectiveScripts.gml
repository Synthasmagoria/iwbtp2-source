#define scrP2ObjectiveScripts
/// scrP2ObjectiveScripts(placeholder0)
var placeholder0 = argument0;
return undefined;

#define scrP2ObjectiveCreate
/// scrP2ObjectiveCreate(name, _room)
var name = argument0, _room = argument1;
var _objective = ds_map_create();
ds_map_add(_objective, "name", name);
ds_map_add(_objective, "room", _room);
return _objective;

#define scrP2ObjectiveAdd
/// scrP2ObjectiveAdd(name, _room)
var name = argument0, _room = argument1;
if (scrP2ObjectiveExists(name)) {
    return undefined;
}
var _objective = scrP2ObjectiveCreate(name, _room);
with (oP2Objectives) {
    ds_list_add_map(objectives, _objective);
    scrP2ObjectiveSignalUpdate();
}

#define scrP2ObjectiveAddCleared
/// scrP2ObjectiveAddCleared(name, _room)
var name = argument0, _room = argument1;
if (scrP2ObjectiveExists(name)) {
    return undefined;
}
var _objective = scrP2ObjectiveCreate(name, _room);
with (oP2Objectives) {
    ds_list_add_map(cleared_objectives, _objective);
}

#define scrP2ObjectiveClearOrAddCleared
var name = argument0, _room = argument1;
if (scrP2ObjectiveExists(name)) {
    scrP2ObjectiveClear(name);
} else {
    var _objective = scrP2ObjectiveCreate(name, _room);
    with (oP2Objectives) {
        ds_list_add_map(cleared_objectives, _objective);
    }
}

#define scrP2ObjectiveClear
/// scrP2ObjectiveClear(name)
var name = argument0;
with (oP2Objectives) {
    var _objective;
    for (var i = 0, n = ds_list_size(objectives); i < n; i++) {
        _objective = ds_list_find_value(objectives, i);
        if (ds_map_find_value(_objective, "name") == name) {
            ds_list_delete(objectives, i);
            ds_list_add_map(cleared_objectives, _objective);
            scrP2ObjectiveSignalUpdate();
            break;
        }
    }
}

#define scrP2ObjectiveExists
/// scrP2ObjectiveExists(name)
var name = argument0;
var _objective_exists = false;
with (oP2Objectives) {
    for (var i = 0, n = ds_list_size(objectives); i < n; i++) {
        _objective_exists |= ds_map_find_value(ds_list_find_value(objectives, i), "name") == name;
    }
    for (var i = 0, n = ds_list_size(cleared_objectives); i < n; i++) {
        _objective_exists |= ds_map_find_value(ds_list_find_value(cleared_objectives, i), "name") == name;
    }
}
return _objective_exists;

#define scrP2ObjectivesGet
with (oP2Objectives) {
    return objectives;
}
return -1;

#define scrP2ObjectivesUpdateRegisterCallback
/// scrP2ObjectivesUpdateRegisterCallback(inst, event)
var inst = argument0, event = argument1;
with (oP2Objectives) {
    for (var i = 0, n = ds_list_size(update_callback_instances); i < n; i++) {
        if (ds_map_find_value(ds_list_find_value(update_callback_instances, i), "instance") == inst) {
            return undefined;
        }
    }
    
    var _registration = ds_map_create();
    ds_map_add(_registration, "instance", inst);
    ds_map_add(_registration, "event", event);
    ds_list_add_map(update_callback_instances, _registration);
}

#define scrP2ObjectiveSignalUpdate
// TODO: Defer this event when multiple objectives are added in one go
with (oP2Objectives) {
    var _callback_instance;
    for (var i = 0, n = ds_list_size(update_callback_instances); i < n; i++) {
        _callback_instance = ds_list_find_value(update_callback_instances, i);
        if (instance_exists(ds_map_find_value(_callback_instance, "instance"))) {
            with (ds_map_find_value(_callback_instance, "instance")) {
                event_user(ds_map_find_value(_callback_instance, "event"));
            }
        } else {
            ds_map_destroy(_callback_instance);
            ds_list_delete(update_callback_instances, i);
            i--;
        }
    }
}