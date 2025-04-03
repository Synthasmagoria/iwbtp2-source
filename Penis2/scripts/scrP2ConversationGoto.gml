/// scrP2ConversationGoto
var conversation_inst = argument0, line_or_id = argument1;

with (conversation_inst) {
    if (is_real(line_or_id)) {
        index = line_or_id;
    } else if (is_string(line_or_id)) {
        if (!is_real(connections[?line_or_id])) {
            print("Conversation error - no id by name " + string(line_or_id) + ", " + string(connections[?line_or_id]));
            return undefined;
        }
        index = connections[?line_or_id];
    } else {
        print("Conversation error - no id by name " + string(line_or_id));
        return undefined;
    }
    
    scrP2TextboxClearCallbacks(textbox_instance);
    if (is_array(textbox_callbacks[|index]) && is_array(textbox_callback_lines[|index])) {
        var
        _callbacks = textbox_callbacks[|index],
        _callback_lines = textbox_callback_lines[|index];
        for (var i = 0, n = array_length_1d(_callbacks); i < n; i++) {
            scrP2TextboxAddCallback(textbox_instance, _callback_lines[i], _callbacks[i]);
        }
    }
    
    if (is_array(branches[|index]) || (is_real(branches[|index]) && branches[|index] != -1)) {
        scrP2TextboxAddCallback(textbox_instance, array_length_1d(text[|index]) - 1, scrP2TextboxCallback_CreateOptions);
    }
    
    textbox_instance.text = text[|index];
    textbox_instance.portrait_emotions = emotions[|index];
    textbox_instance.text_speed = speeds[|index];
    with (textbox_instance) {
        event_user(0);
    }
}
