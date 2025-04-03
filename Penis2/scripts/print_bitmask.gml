/// print_bitmask
var int = argument0;
var _bitmask_str = "";
for (var i = 0; i < 32; i++) {
    _bitmask_str += string(int_get_bit(int, i));
}
print(_bitmask_str);
