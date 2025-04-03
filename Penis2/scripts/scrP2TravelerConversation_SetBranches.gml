/// scrP2TravelerConversation_SetBranches
with (objP2Conversation) {
    var _branches = ds_list_create();
    if (!int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q1))
        ds_list_add(_branches, "Where does the elevator go?");
    if (!int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q2))
        ds_list_add(_branches, "Where is the exit?");
    if (!int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q3))
        ds_list_add(_branches, "Do you know IdiotSavant?");
    if (!int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q4))
        ds_list_add(_branches, "Who are you?");
    if (int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q1) &&
        int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q2) &&
        int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q3) &&
        int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q4) &&
        !int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q5))
        ds_list_add(_branches, "What makes you different?");
    ds_list_add(_branches, "Later");
    
    var _value;
    if (ds_list_size(_branches) == 0) {
        _value = -1;
    } else {
        _value = ds_list_array(_branches);
    }
    
    if (ds_list_size(branches) == 0) {
        ds_list_add(branches, _value);
    } else {
        branches[|0] = _value;
    }
    
    ds_list_destroy(_branches);
}
