/// scrP2TriggerEvent_SpawnEel
global.p2Flag = int_truth_bit(global.p2Flag, P2_FLAG.EEL_APPEARANCE);
global.saveP2Flag = int_truth_bit(global.saveP2Flag, P2_FLAG.EEL_APPEARANCE);
instance_create(0, 0, objP2CorruptionEel);
