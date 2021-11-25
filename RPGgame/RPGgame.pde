// RPG Game //





// Variables //

// Mode Framework
final int INTRO = 0;  
final int GAME = 1;
int mode;

// Colors
color roomFloor = 230;
color roomTile = 210;
color roomWall = #4B48B2;
color door = #39407E;
color iWeapon = 75;  // Item weapon
color iWeapon_s = 0;  // Stroke
color iHealth = #3EFF49;  // Health pack item
color iHealth_s = #48ED51; // Stroke

// Room values
float wallSize;  
float default_wallSize;
float gameScale;
float default_roomScale;
float roomSize;
float roomX, roomY;
float doorSize;
float default_doorSize;

// Objects
ArrayList<Room> myRooms; 
ArrayList<Room> tempRooms;
ArrayList<gameObject> myObjects;
Player myPlayer;

// Game
boolean leftWall, rightWall, upWall, downWall;  // true if touching wall
boolean leftDoor, rightDoor, upDoor, downDoor;  // true if door exists
boolean leftMove, rightMove, upMove, downMove;  // true if can move in that direction
int newRoom = -1;
float darknessSize;  // Size of darkness pixels
int[][] minimap;  // Minimap array
int rows, cols;
int roomRow, roomCol;
float inSize, inOffset; // Weapon indicator
float slY, slTargetY, default_slSpeed, slSpeed;  // Weapon selector

// Font
PFont consolas;

// Icons
PImage[] gunIcons;

// Other
int debug = 1;


void setup() { 
  size(960, 540, FX2D);
  background(255);
  scaleWindow();
  
  // Mode Framework
  mode = GAME;
  
  // Room values
  roomSize = 1000;
  default_roomScale = 0.5;
  default_wallSize = 50;
  default_doorSize = 200;
  roomX = 0;
  roomY = 0;
  
  // Objects
  myRooms   = new ArrayList<Room>();
  myObjects = new ArrayList<gameObject>();
  tempRooms = new ArrayList<Room>();
  myPlayer  = new Player();
  myRooms  .add(new Room(0,0, -2));
  myObjects.add(new Laser());
  myObjects.add(myPlayer);
  
  
   // Game
  darknessSize = 5;
  rows = 8;
  cols = 8;
  minimap = new int[][]{  // Initialize map
    {0,0,0,0,0,0,0,0},
    {0,0,0,0,1,1,1,0},
    {0,0,2,3,1,1,1,0},  
    {0,0,1,0,0,1,1,0},   
    {0,1,1,0,0,1,0,0},  
    {0,1,1,1,1,1,0,0},
    {0,1,1,1,0,0,0,0},
    {0,0,0,0,0,0,0,0}
  };
  roomRow = 3;  // Starting room
  roomCol = 3;
  default_slSpeed = slSpeed = 10;
  
  // Font
  consolas = createFont("Consolas", 1);
  
  // Icons
  gunIcons = new PImage[] {
    loadImage("basic_gun.png"),
    loadImage("rapid.png"),
    loadImage("rifle.png"),
    loadImage("shotgun.png")
  };
  
  InitializeEnemies();
}


void draw() {
  detectClicks();
  scaleWindow();
  switch(mode) {  // Mode Framework
    case INTRO: intro(); break;
    case GAME:  game();  break;
  }
}


void InitializeEnemies() {
  for(int r = 1; r <= rows; r++) {  // Scan
    for(int c = 1; c <= cols; c++) {
      int cell = minimap[r-1][c-1];
      switch(cell) {
        case 1: case 0: break;  // No enemies
        case 2:  // 4 turrets
          myObjects.add(new Turret(-200,-200, c,r));
          myObjects.add(new Turret(200,-200, c,r));
          myObjects.add(new Turret(-200,200, c,r));
          myObjects.add(new Turret(200,200, c,r));
          break;
        case 3:  // Followers
          for(int i = 0; i < 10; i++) myObjects.add(new Follower(random(-100,100),random(-100,100), c,r));
      }
    }
  }
}
