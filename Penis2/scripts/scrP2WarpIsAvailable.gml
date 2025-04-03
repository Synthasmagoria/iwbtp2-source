/// scrP2WarpIsAvailable
with (objPlayer) {
    return !frozen && (global.p2Crystal == global.saveP2Crystal) && global.gameStarted && instance_exists(objPlayer);
}
return false;
