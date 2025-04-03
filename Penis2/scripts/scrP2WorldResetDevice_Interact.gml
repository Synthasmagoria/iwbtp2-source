/// scrP2WorldResetDevice_Interact
var inst = argument0;
if (audio_is_playing(global.currentMusic)) {
    audio_stop_sound(global.currentMusic);
}
with (objPlayer) {
    frozen = true;
}
with (inst) {
    event_user(0);
}
