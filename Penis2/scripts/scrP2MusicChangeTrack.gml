/// scrP2MusicChangeTrack(sound)->void
var sound = argument0;
global.currentMusicID = sound;
var _current_song_position = audio_sound_get_track_position(global.currentMusic);
audio_stop_sound(global.currentMusic);
global.currentMusic = audio_play_sound(sound, 0, true);
audio_sound_set_track_position(global.currentMusic, _current_song_position);
