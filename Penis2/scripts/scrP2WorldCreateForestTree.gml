/// scrP2RoomTreeAdd(x, y, tree_grid, xorigin, yorigin, xflip, yflip, bg)
var xx = argument0, yy = argument1, tree = argument2, xorigin = argument3, yorigin = argument4, xflip = argument5, yflip = argument6, bg = argument7;
enum P2_TREE {
    NOTHING,
    TRUNK,
    LEAF,
    BRANCH,
    __MAX
}

var
_tree_w = ds_grid_width(tree),
_tree_h = ds_grid_height(tree),
_tree_left, _tree_top, _place_x, _place_y, _sample_x, _sample_y;

if (!xflip) {
    _tree_left = xx - xorigin * 32;
} else {
    _tree_left = xx - (_tree_w - xorigin - 1) * 32;
}

if (!yflip) {
    _tree_top = yy - yorigin * 32;
} else {
    _tree_top = yy - (_tree_h - yorigin - 1) * 32;
}

with (instance_find(oP2World, 0)) {
    for (var _x = 0, w = _tree_w; _x < w; _x++) {
        if (!xflip) {
            _sample_x = _x;
        } else {
            _sample_x = _tree_w - _x - 1;
        }
        for (var _y = 0, h = _tree_h; _y < h; _y++) {
            if (!yflip) {
                _sample_y = _y;
            } else {
                _sample_y = _tree_h - _y - 1;
            }
            _place_x = _tree_left + _x * 32;
            _place_y = _tree_top + _y * 32;
            switch (tree[#_sample_x, _sample_y]) {
                case P2_TREE.TRUNK:
                scrP2WorldInternalCreateForestInstance(_place_x, _place_y, objBlock);
                scrP2WorldInternalCreateForestTile(_place_x, _place_y, 0, 96, bg);
                break;
                
                case P2_TREE.LEAF:
                scrP2WorldInternalCreateForestInstance(_place_x, _place_y, objP2LeafBlock);
                break;
                
                case P2_TREE.BRANCH:
                scrP2WorldInternalCreateForestInstance(_place_x, _place_y, objBlock);
                scrP2WorldInternalCreateForestTile(_place_x, _place_y, 0, 96 + 32 * (irandom(1) < 0.5), bg);
                scrP2WorldInternalCreateForestInstance(_place_x, _place_y, objP2LeafBlock);
                break;
            }
        }
    }
}
