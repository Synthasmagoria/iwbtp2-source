/// scrP2WallCreateBlocks(wall_bits, xx, yy, blocks_out)
var wall_bits = argument0, xx = argument1, yy = argument2, blocks_out = argument3;

var _block_thickness = 1;
ds_list_clear(blocks_out);

switch (wall_bits) {
    case 0:
        break;
    case 511 ^ P2_TILING_BITS.MIDDLE:
    case 511:
        ds_list_add(blocks_out, instance_create(xx, yy, objBlock));
        break;
    default:
        var _block;
        
        if (int_read_bit(wall_bits, P2_TILING_BIT_POSITIONS.RIGHT)) {
            _block = instance_create(xx + __P2_TILE_SIZE - _block_thickness, yy, objBlock);
            instance_set_width(_block, _block_thickness);
            ds_list_add(blocks_out, _block);
        }
        if (int_read_bit(wall_bits, P2_TILING_BIT_POSITIONS.TOP)) {
            _block = instance_create(xx, yy, objBlock);
            instance_set_height(_block, _block_thickness);
            ds_list_add(blocks_out, _block);
        }
        if (int_read_bit(wall_bits, P2_TILING_BIT_POSITIONS.LEFT)) {
            _block = instance_create(xx, yy, objBlock);
            instance_set_width(_block, _block_thickness);
            ds_list_add(blocks_out, _block);
        }
        if (int_read_bit(wall_bits, P2_TILING_BIT_POSITIONS.BOTTOM)) {
            _block = instance_create(xx, yy + __P2_TILE_SIZE - _block_thickness, objBlock);
            instance_set_height(_block, _block_thickness);
            ds_list_add(blocks_out, _block);
        }
        break;
}
