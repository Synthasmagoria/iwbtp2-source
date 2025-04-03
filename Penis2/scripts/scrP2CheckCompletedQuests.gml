/// scrP2CheckCompletedQuests
if (int_get_bit(global.saveP2Item, P2_ITEM.WRENCH))
    scrP2ObjectiveClearOrAddCleared("Look into chaos", room_get_name(rP2Intro08));
if (int_get_bit(global.saveP2Crystal, P2_CRYSTAL.PURPLE))
    scrP2ObjectiveClearOrAddCleared("Purple Crystal", room_get_name(rP2IntroOOB_FarLeft));
if (int_get_bit(global.saveP2Crystal, P2_CRYSTAL.RED))
    scrP2ObjectiveClearOrAddCleared("Red Crystal", room_get_name(rP2Intro04));
if (int_get_bit(global.saveP2Crystal, P2_CRYSTAL.BLUE))
    scrP2ObjectiveClearOrAddCleared("Blue Crystal", room_get_name(rP2Edge_2));
