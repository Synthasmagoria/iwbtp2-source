/// scrP2TextboxCallback_CreateOptions
with (objP2Conversation) {
    var
    _branch = branches[|index],
    _inst;
    if (is_real(_branch)) {
        _inst = scrP2TextboxCreateOptions(textbox_instance, branches[|_branch]);
    } else if (is_array(_branch)) {
        _inst = scrP2TextboxCreateOptions(textbox_instance, _branch);
    }
    _inst.select_callback = scrP2Conversation_SelectCallback;
}
