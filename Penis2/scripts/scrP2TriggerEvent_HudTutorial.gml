/// scrP2TriggerEvent_HudTutorial
scrP2TextboxCreate("TIP: You can resize the map using the 'X' button.", -1, -1, 1, array(scrP2UnfreezePlayer), array(9999));
audio_play_sound(sndSignPopup, 0, false);
global.p2Flag = int_truth_bit(global.p2Flag, P2_FLAG.HUD_TUTORIAL);
with (objPlayer) {
    frozen = true;
}
