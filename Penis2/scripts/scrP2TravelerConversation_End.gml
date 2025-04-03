/// scrP2TravelerConversation_End
var _interactable = scrP2InstanceGetTaggedFirst(objP2Interactable, "traveler");
_interactable.disabled = false;
global.p2Flag = int_set_bit(global.p2Flag, P2_FLAG.TRAVELER_TALKING, false);
global.saveP2Flag = int_set_bit(global.saveP2Flag, P2_FLAG.TRAVELER_TALKING, false);
global.p2Flag = int_set_bit(global.p2Flag, P2_FLAG.TRAVELER_VANISHED_AGAIN, false);
global.saveP2Flag = int_set_bit(global.saveP2Flag, P2_FLAG.TRAVELER_VANISHED_AGAIN, false);
with (objPlayer) {
    frozen = false;
}
