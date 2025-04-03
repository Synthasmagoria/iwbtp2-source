/// buffer_write_string_aligned(buffer, str, bytes)
var buffer = argument0, str = argument1, bytes = argument2;
var _prev_pos = buffer_tell(buffer);
buffer_write(buffer, buffer_text, str);
buffer_seek(buffer, buffer_seek_relative, _prev_pos - buffer_tell(buffer) + bytes);
