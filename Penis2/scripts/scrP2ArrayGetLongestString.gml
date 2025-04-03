/// scrP2ArrayGetLongestString
var arr = argument0;
var _len = 0;
for (var i = 0, n = array_length_1d(arr); i < n; i++) {
    _len = max(_len, string_width(arr[i]));
}
return _len;
