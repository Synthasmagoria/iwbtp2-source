/// scrP2TravelerSpawn_NuclearPhysicistKid
with (objP2Traveler) {
    audio_play_sound(sndP2Throw, 0, false);
    var _inst = instance_create(x, y - 16, oP2NuclearPhysicistSkin);
    _inst.direction = 115;
    _inst.speed = 8;
}
