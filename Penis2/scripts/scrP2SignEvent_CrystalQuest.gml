/// scrP2SignEvent_CrystalQuest
if (scrP2HudGetScale() == P2_HUD_SCALE.MINIMIZED)
    scrP2HudSetScale(P2_HUD_SCALE.NORMAL);
if (!scrP2ObjectiveExists("Purple Crystal"))
    instance_create(0, 0, oP2MapNotification);
scrSynthMapRoom("rP2IntroOOB_FarLeft", 0, 608 * 2, 800, 608 * 4);
scrSynthMapRoom("rP2Intro04", 800 * 4, 608, 800, 608);
scrSynthMapRoom("rP2Edge_2", 800 * 10, 0, 800, 608);
scrP2ObjectiveAdd("Purple Crystal", "rP2IntroOOB_FarLeft");
scrP2ObjectiveAdd("Red Crystal", "rP2Intro04");
scrP2ObjectiveAdd("Blue Crystal", "rP2Edge_2");
