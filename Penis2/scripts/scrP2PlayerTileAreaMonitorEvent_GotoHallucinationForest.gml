/// scrP2PlayerTileAreaMonitorEvent_GotoHallucinationForest
room_goto(rP2ForestHallucination);
global.gameStarted = false;
global.p2Flag = int_truth_bit(global.p2Flag, P2_FLAG.HALLUCINATED_FOREST);
global.saveP2Flag = int_truth_bit(global.saveP2Flag, P2_FLAG.HALLUCINATED_FOREST);
with (objPlayer) {
    x = x - view_xview[0] + view_wview[0];
    y = y - view_yview[0] + view_hview[0];
}
