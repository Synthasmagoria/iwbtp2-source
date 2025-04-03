/// scrP2StringFormatMono(str, char_width, line_width, lines_per_paragraph, text_out)->undefined
var str = argument0, char_width = argument1, line_width = argument2, lines_per_paragraph = argument3, text_out = argument4;

if (!is_array(str)) {
    str[0] = str;
}

for (var i = 0, n = array_length_1d(str); i < n; i++) {
    var
    _paragraph_with_linebreaks = "",
    _line_start = 1,
    _line_end = 1,
    _line_index = 0,
    _line_length = floor(line_width / char_width),
    _text_length = string_length(str[i]);
    
    while (true) {
        _line_end += _line_length;
        
        if (_line_end >= _text_length) {
            _paragraph_with_linebreaks += string_copy(str[i], _line_start, _text_length - _line_start + 1);
            ds_list_add(text_out, _paragraph_with_linebreaks);
            break;
        }
        
        while (string_char_at(str[i], _line_end) != " ") {
            _line_end--;
        }
        
        _paragraph_with_linebreaks += string_copy(str[i], _line_start, _line_end - _line_start);
        _line_index++;
        
        if (_line_index < lines_per_paragraph) {
            _paragraph_with_linebreaks += "#";
        }
        
        if (_line_index >= lines_per_paragraph) {
            ds_list_add(text_out, _paragraph_with_linebreaks);
            _line_index = 0;
            _paragraph_with_linebreaks = "";
        }
        
        _line_end++;
        _line_start = _line_end;
    }
}
