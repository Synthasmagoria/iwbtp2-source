///print(str);
if (is_real(argument0) && ds_exists(argument0, ds_type_list)) {
    var _buf_str = buffer_create(512, buffer_grow, 1);
    buffer_write(_buf_str, buffer_text, "[");
    for (var i = 0, n = ds_list_size(argument0); i < n; i++) {
        buffer_write(_buf_str, buffer_text, string(argument0[|i]) + ", ");
    }
    buffer_write(_buf_str, buffer_text, "]");
    buffer_seek(_buf_str, buffer_seek_start, 0);
    show_debug_message(buffer_read(_buf_str, buffer_text));
    buffer_delete(_buf_str);
} else {
    show_debug_message(argument0);
}
