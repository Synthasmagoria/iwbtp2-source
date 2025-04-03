/// scrP2TreeFits(x, y, ydir, height, tilemap)
var xx = argument0, yy = argument1, ydir = argument2, height = argument3, tilemap = argument4;
var
_tmw = ds_grid_width(tilemap),
_tmh = ds_grid_height(tilemap),
_fits = true,
_ydir = sign(ydir),
_ycheck;
for (var i = 0; i < height; i++) {
    _ycheck = yy + (i + 1) * _ydir;
    if ((point_in_rectangle(xx, _ycheck, 0, 0, _tmw, _tmh) && ds_grid_get(tilemap, xx, _ycheck) != -1) ||
        (point_in_rectangle(xx + 1, _ycheck, 0, 0, _tmw, _tmh) && ds_grid_get(tilemap, xx + 1, _ycheck) != -1) ||
        (point_in_rectangle(xx - 1, _ycheck, 0, 0, _tmw, _tmh) && ds_grid_get(tilemap, xx - 1, _ycheck) != -1)) {
        _fits = false;
        break;
    }
}
return _fits;
