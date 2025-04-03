/// scrP2WorldCreateForestInstance(x, y, obj)
var xx = argument0, yy = argument1, obj = argument2;
var _inst = forest_instance_pool[|forest_instance_pool_index];
_inst[?"x"] = xx;
_inst[?"y"] = yy;
_inst[?"obj"] = obj;
ds_list_add(forest_instances, _inst);
forest_instance_pool_index = (forest_instance_pool_index + 1) % ds_list_size(forest_instance_pool);
