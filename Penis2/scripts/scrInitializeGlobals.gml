///initializes all global variables needed for the game

math_set_epsilon(0.00001); // dw this is the same epsilon as the vm runner

global.__p2_tilemap = -1;
global.__p2_room_tiles = -1;
global.__p2_current_room_x = -1;
global.__p2_current_room_y = -1;

//P2 ITEMS
enum P2_ITEM {
    WRENCH,
    WARP_ORB,
    UNSCRAMBLER,
    WORLD_BORDER_DETECTOR,
    __NUMBER
}
global.p2Item = 0;
global.saveP2Item = 0;

enum P2_CRYSTAL {
    PURPLE,
    RED,
    BLUE,
    __NUMBER
}
global.p2Crystal = 0;
global.saveP2Crystal = 0;

enum P2_FLAG {
    HUD_TUTORIAL,
    EEL,
    TRAVELER_TALKED,
    TRAVELER_TALKING,
    TRAVELER_GONE,
    TRAVELER_Q1,
    TRAVELER_Q2,
    TRAVELER_Q3,
    TRAVELER_Q4,
    TRAVELER_Q5,
    NO_ESCAPE_WARP_TOUCHED,
    TRAVELER_VANISHED_AGAIN,
    OOB_DISCOVERED,
    HALLUCINATED_FOREST,
    EEL_APPEARANCE,
    HALLUCINATED_FOREST_AUTUMN,
    HALLUCINATED_FOREST_WINTER,
    __NUMBER
}
global.p2Flag = 0;
global.saveP2Flag = 0;


scrSetGlobalOptions();       //initialize global game options

global.savenum = 1;
global.difficulty = 0;  //0 = medium, 1 = hard, 2 = very hard, 3 = impossible
global.death = 0;
global.time = 0;
global.timeMicro = 0;
global.saveRoom = "";
global.savePlayerX = 0;
global.savePlayerY = 0;
global.savePlayerFacing = 1;
global.grav = 1;
global.saveGrav = 1;

for (var i = global.secretItemTotal-1; i >= 0; i--)
{
    global.secretItem[i] = false;
    global.saveSecretItem[i] = false;
}

for (var i = global.bossItemTotal-1; i >= 0; i--)
{
    global.bossItem[i] = false;
    global.saveBossItem[i] = false;
}

global.gameClear = false;
global.saveGameClear = false;

for (var i = 99; i >= 0; i--)
{
    global.trigger[i] = false;
}

global.gameStarted = false;     //determines whether the game is in progress (enables saving, restarting, etc.)
global.noPause = false;         //sets whether or not to allow pausing (useful for bosses to prevent desync)
global.autosave = false;        //keeps track of whether or not to autosave the next time the player is created
global.noDeath = false;         //keeps track of whether to give the player god mode
global.infJump = false;         //keeps track of whether to give the player infinite jump

global.gamePaused = false;      //keeps track of whether the game is paused or not
global.pauseSurf = -1;       //stores the screen surface when the game is paused
global.pauseDelay = 0;      //sets pause delay so that the player can't quickly pause buffer

global.currentMusicID = -1;  //keeps track of what song the current music is
global.currentMusic = -1;    //keeps track of current main music instance
global.deathSound = -1;     //keeps track of death sound when the player dies
global.gameOverMusic = -1;   //keeps track of game over music instance
global.musicFading = false;     //keeps track of whether the music is being currently faded out
global.currentGain = 0;     //keeps track of current track gain when a song is being faded out

global.menuSelectPrev[0] = 0;     //keeps track of the previously selected option when navigating away from the difficulty menu
global.menuSelectPrev[1] = 0;     //keeps track of the previously selected option when navigating away from the options menu

//get the default window size
global.windowWidth = surface_get_width(application_surface);
global.windowHeight = surface_get_height(application_surface);

//keeps track of previous window position/size when display_reset is used for setting vsync
global.windowXPrev = 0;
global.windowYPrev = 0;
global.windowWidthPrev = 0;
global.windowHeightPrev = 0;

display_set_gui_size(surface_get_width(application_surface),surface_get_height(application_surface));  //set the correct gui size for the Draw GUI event

global.controllerMode = false;  //keeps track of whether to use keyboard or controller
global.controllerDelay = -1;    //handles delay between switching between keyboard/controller so that the player can't use both at the same time

randomize();    //make sure the game starts with a random seed for RNG

scheduler_resolution_set(1);    //make sure 1 ms timing is used from game start
