/// scrP2PlayerTileAreaMonitorEvent_GotoWinterHallucinationForest
room_goto(rP2ForestHallucination_Winter);
global.gameStarted = false;
global.p2Flag = int_truth_bit(global.p2Flag, P2_FLAG.HALLUCINATED_FOREST_WINTER);
global.saveP2Flag = int_truth_bit(global.saveP2Flag, P2_FLAG.HALLUCINATED_FOREST_WINTER);
with (objPlayer) {
    x = x - view_xview[0] + view_wview[0];
    y = y - view_yview[0] + view_hview[0];
}
