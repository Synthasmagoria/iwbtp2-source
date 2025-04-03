/// array_randomize(arr)
var arr = argument0;

var len = array_length_1d(arr), ind, temp;

for (var i = 0; i < len - 1; i++)
{
	temp = arr[@ i];
	ind = i + irandom(len - i - 2) + 1;
	arr[@ i] = arr[@ ind];
	arr[@ ind] = temp;
}
