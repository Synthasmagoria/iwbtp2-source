/// scrP2SignEvent_ChaosQuest
if (scrP2HudGetScale() == P2_HUD_SCALE.MINIMIZED)
    scrP2HudSetScale(P2_HUD_SCALE.NORMAL);
if (!scrP2ObjectiveExists("Look into chaos"))
    instance_create(0, 0, oP2MapNotification);
var _room = scrSynthMapRoom("rP2Intro08", 800 * 7, 608 * 3, 800 * 4, 608 * 3);
scrSynthMapRoomFocus(_room, false);
scrP2ObjectiveAdd("Look into chaos", "rP2Intro08");
