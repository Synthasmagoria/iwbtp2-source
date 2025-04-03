/// scrP2WallDestroyBlocks
var block_list = argument0;
for (var i = ds_list_size(block_list) - 1; i >= 0; i--) {
    instance_destroy(block_list[|i]);
}
ds_list_clear(block_list);
