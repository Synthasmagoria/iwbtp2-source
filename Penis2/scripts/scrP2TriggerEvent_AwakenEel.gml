/// scrP2TriggerEvent_AwakenEel
audio_play_sound(sndP2Eel, 0, false);
global.p2Flag = int_truth_bit(global.p2Flag, P2_FLAG.EEL);
global.saveP2Flag = int_truth_bit(global.saveP2Flag, P2_FLAG.EEL);
scrP2WorldDelayedExecution(4, scrP2TriggerEvent_AwakenEelText);

with (objPlayer)
    frozen = true;
global.gameStarted = false;

var _inst_list = scrP2InstanceGetTagged(objP2Trigger, "eel");
for (var i = 0, n = ds_list_size(_inst_list); i < n; i++) {
    _inst_list[|i].disabled = true;
}
ds_list_destroy(_inst_list);
