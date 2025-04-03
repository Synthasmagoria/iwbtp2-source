/// buffer_read_string(buffer, bytes)
var buffer = argument0, bytes = argument1;
var _prev_pos = buffer_tell(buffer);
var _str = buffer_read(buffer, buffer_text);
buffer_seek(buffer, buffer_seek_relative, _prev_pos - buffer_tell(buffer) + bytes);
return _str;
