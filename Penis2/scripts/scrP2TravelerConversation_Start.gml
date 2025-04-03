/// scrP2TravelerConversation_Start
var interactible = argument0;
interactible.disabled = true;

var _traveler = instance_find(objP2Traveler, 0);
with (objPlayer) {
    var _facing = sign(_traveler.x - x);
    if (_facing != 0) {
        xScale = _facing;
        frozen = true;
    }
}

with (instance_create(0, 0, objP2Conversation)) {
    conversation_end_callback = scrP2TravelerConversation_End;
    
    portrait = sprP2TravelerPortrait;
    
    if (!int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_TALKED)) {
        ds_list_add(text, array(
            "Good morning, or evening?",
            "I've lost track of time a bit since I've been so focused on fixing this elevator.",
            "I need to get it running to be able to get out of here.",
            "You seem like you're well on your way yourself.",
            "...",
            "Ah, am I not making sense?",
            "Feel free to ask some questions then. Though, I don't have much time."));
        ds_list_add(speeds, array(1, 1, 1, 1, 0.04, 1, 1));
        ds_list_add(emotions, array(
            P2_EMOTIONS.NEUTRAL,
            P2_EMOTIONS.NEUTRAL,
            P2_EMOTIONS.NEUTRAL,
            P2_EMOTIONS.NEUTRAL,
            P2_EMOTIONS.FLUSTERED,
            P2_EMOTIONS.NEUTRAL, 
            P2_EMOTIONS.HAPPY));
    } else if (
        int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q1) &&
        int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q2) &&
        int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q3) &&
        int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q4) &&
        int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_Q5)) {
        ds_list_add(text, array("Leave me alone now. I'm trying to get this elevator running again."));
        ds_list_add(speeds, 1);
        ds_list_add(emotions, array(P2_EMOTIONS.NEUTRAL));
    } else {
        if (!int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_TALKING)) {
            ds_list_add(text, array(
                "Hi again.",
                "Wondering about anything?"));
            ds_list_add(speeds, 1);
            ds_list_add(emotions, array(P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.NEUTRAL));
        } else {
            if (!int_get_bit(global.p2Flag, P2_FLAG.TRAVELER_VANISHED_AGAIN)) {
                global.p2Flag = int_truth_bit(global.p2Flag, P2_FLAG.TRAVELER_VANISHED_AGAIN);
                global.saveP2Flag = int_truth_bit(global.saveP2Flag, P2_FLAG.TRAVELER_VANISHED_AGAIN);
                ds_list_add(text, array(
                    "It's rude to vanish mid-conversation. Show some manners.",
                    "What's up?"));
                ds_list_add(speeds, 1);
                ds_list_add(emotions, array(P2_EMOTIONS.ANNOYED, P2_EMOTIONS.NEUTRAL));
            } else {
                ds_list_add(text, array("..."));
                ds_list_add(speeds, 0.04);
                ds_list_add(emotions, array(P2_EMOTIONS.ANNOYED));
            }
        }
    }
    
    ds_list_add(textbox_callbacks, -1);
    ds_list_add(textbox_callback_lines, -1);
    scrP2TravelerConversation_SetBranches();
    
    ds_map_add(connections, "Where does the elevator go?", 1);
    ds_list_add(text, array(
        "It goes to all kinds of places. In terms of functionality it is more of a vehicle.",
        "However, figuring out how to make it take you to the right place is a puzzle.",
        "The fact that I find it enjoyable to operate might be what is keeping me sane.",
        "Luckily you don't need to concern yourself with it since you've already found a way out.",
        "Anything else?"));
    ds_list_add(speeds, 1);
    ds_list_add(emotions, array(P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.HAPPY, P2_EMOTIONS.HAPPY, P2_EMOTIONS.NEUTRAL));
    ds_list_add(branches, 0);
    ds_list_add(textbox_callbacks, array(scrP2TravelerConversation_Q1Answered));
    ds_list_add(textbox_callback_lines, array(0));
    
    ds_map_add(connections, "Where is the exit?", 2);
    ds_list_add(text, array(
        "...",
        "Just go beyond what IdiotSavant thinks is possible.",
        "Having made your way here is a good start. Keep going!",
        "Anything else?"));
    ds_list_add(speeds, array(0.04, 1, 1, 1));
    ds_list_add(emotions, array(P2_EMOTIONS.FLUSTERED, P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.HAPPY, P2_EMOTIONS.NEUTRAL));
    ds_list_add(branches, 0);
    ds_list_add(textbox_callbacks, array(scrP2TravelerConversation_Q2Answered));
    ds_list_add(textbox_callback_lines, array(0));
    
    ds_map_add(connections, "Do you know IdiotSavant?", 3);
    ds_list_add(text, array(
        "IdiotSavant is the creator of this place. Its god so to speak.",
        "Though I don't think he intended for this place to exist to begin with.",
        "His own delusions are sustaining and corrupting this place.",
        "It creates a sort of equilibrium.",
        "At least for as long as he believes things have to be this way.",
        "Anything else?"));
    ds_list_add(speeds, 1);
    ds_list_add(emotions, array(P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.ANNOYED, P2_EMOTIONS.NEUTRAL));
    ds_list_add(branches, 0);
    ds_list_add(textbox_callbacks, array(scrP2TravelerConversation_Q3Answered));
    ds_list_add(textbox_callback_lines, array(0));
    
    ds_map_add(connections, "Who are you?", 4);
    ds_list_add(text, array(
        "A traveler from the third layer of delusion.",
        "In my moments of clarity I try to make it back up to the surface.",
        "But, I often find myself back in the depths.",
        "I try not to say always...",
        "Luckily I've got medical supplies with me and a reliable source of food and drink.",
        "Anything else?"));
    ds_list_add(speeds, 1);
    ds_list_add(emotions, array(P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.PENSIVE, P2_EMOTIONS.PENSIVE, P2_EMOTIONS.HAPPY, P2_EMOTIONS.NEUTRAL));
    ds_list_add(branches, 0);
    ds_list_add(textbox_callbacks, array(scrP2TravelerConversation_Q4Answered));
    ds_list_add(textbox_callback_lines, array(0));
    
    ds_map_add(connections, "What makes you different?", 5);
    ds_list_add(text, array(
        "If you'd carve out my left eye and look at the back of the optical disk.",
        "You'd find a little burn mark in the shape of a crown.",
        "It's the result of seeing an eel, unlike any of the ones you can find in this realm.",
        "I can almost guarantee you don't have it."))
    ds_list_add(speeds, 1);
    ds_list_add(emotions, array(P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.HAPPY));
    ds_list_add(branches, 0);
    ds_list_add(textbox_callbacks, array(scrP2TravelerConversation_Q5Answered));
    ds_list_add(textbox_callback_lines, array(0));
    
    ds_map_add(connections, "Later", 6);
    // TODO: Change this to the value for storing player skins
    if (!global.secretItem[0] && !instance_exists(oP2NuclearPhysicistSkin)) {
        ds_list_add(text, array(
            "Yeah. sure.",
            "Right, before I forget.",
            "I found some old clothes lying around.",
            "If you ignore the chemical stains it'll make for a nice outfit."));
        ds_list_add(emotions, array(P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.NEUTRAL, P2_EMOTIONS.HAPPY));
        ds_list_add(textbox_callbacks, array(scrP2TravelerSpawn_NuclearPhysicistKid));
        ds_list_add(textbox_callback_lines, array(9999));
    } else {
        ds_list_add(text, array("Yeah. sure."));
        ds_list_add(emotions, P2_EMOTIONS.NEUTRAL);
        ds_list_add(textbox_callbacks, -1);
        ds_list_add(textbox_callback_lines, -1);
    }
    ds_list_add(branches, -1);
    ds_list_add(speeds, 1);
    event_user(0);
}

global.p2Flag = int_truth_bit(global.p2Flag, P2_FLAG.TRAVELER_TALKING);
global.saveP2Flag = int_truth_bit(global.saveP2Flag, P2_FLAG.TRAVELER_TALKING);
global.p2Flag = int_truth_bit(global.p2Flag, P2_FLAG.TRAVELER_TALKED);
global.saveP2Flag = int_truth_bit(global.saveP2Flag, P2_FLAG.TRAVELER_TALKED);
