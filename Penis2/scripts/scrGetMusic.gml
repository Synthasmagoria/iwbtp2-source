///gets which song is supposed to be playing for the current room and plays it

var roomSong;

switch (room)
{
    case rTitle:
    case rOptions:
    case rRealMenDontDie:
        if (file_exists(scrP2SaveDataGetName())) {
            roomSong = -1;
        } else {
            roomSong = musRealmen;
        }
        break;
        
    case rP2EntranceDemo:
        roomSong = musCrystal;
        break;
    
    case rP2Intro01:
    case rP2Intro02:
    case rP2Intro03:
    case rP2Intro04:
    case rP2Intro05:
    case rP2Intro06:
    case rP2Intro07:
    case rP2IntroPonycutz:
    case rP2FapMyBeloved:
    case rP2NoEscape:
    case rP2IntroOOB_BottomMiddle_0:
    case rP2IntroOOB_BottomMiddle_1:
    case rP2IntroOOB_BottomMiddle_2:
    case rP2IntroOOB_BottomRight:
    case rP2IntroOOB_FarLeft:
    case rP2IntroFall:
    case rP2Wasteland:
    case rP2Tree:
    case rP2Edge_0:
    case rP2Edge_1:
    case rP2Edge_2:
    case rP2Nuclear:
    case rP2EdgePit_1:
    case rP2EdgePit_2:
    if (!int_get_bit(global.saveP2Item, P2_ITEM.WRENCH)) {
        if (srcP2WorldRoomIsOOB(room)) {
            roomSong = musP2Loop2B;
        } else {
            roomSong = musP2Loop1;
        }
    } else {
        if (srcP2WorldRoomIsOOB(room)) {
            roomSong = musP2Loop2B;
            if (global.currentMusicID == musP2Loop2A) {
                scrP2MusicChangeTrack(roomSong);
            }
        } else {
            roomSong = musP2Loop2A;
            if (global.currentMusicID == musP2Loop2B) {
                scrP2MusicChangeTrack(roomSong);
            }
        }
    }
    break;
    
    case rP2SlugTilingTest_0:
    case rP2SlugTilingTest_1:
    case rP2SlugTilingTest_2:
    roomSong = musP2Loop2C;
    break;
    
    case rP2Intro08:
    roomSong = musP2Chaos;
    break;
    
    case rP2Between:
    roomSong = musP2Between;
    break;
    
    case rP2WrenchTutorial:
    roomSong = musP2WrenchTutorial;
    break;
    
    case rP2Interlude:
    roomSong = musP2Interlude;
    break;
    
    case rP2Menu:
    case rP2MenuUnresponsive:
    case rP2MenuSaveSelect:
    case rP2MenuStartGame:
    case rP2MenuDifficultySelect:
        roomSong = -2;
        break;
    
    default:
        roomSong = -1;
        break;
}

if (roomSong != -2)
    scrPlayMusic(roomSong,true);
