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


void setup() { 
  size(960, 540);
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
  
  myObjects.add(new Turret(100, -100, 3,3));  // Test enemy
  myObjects.add(new Follower(100, 100, 3,4));  // Test enemy
  
   // Game
  darknessSize = 5;
  rows = 8;
  cols = 8;
  minimap = new int[][]{  // Initialize map
    {0,0,0,0,0,0,0,0},
    {0,0,0,0,1,1,1,0},
    {0,0,1,1,1,1,1,0},  
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
  //println(frameRate);
  detectClicks();
  scaleWindow();
  switch(mode) {  // Mode Framework
    case INTRO: intro(); break;
    case GAME:  game();  break;
  }
}


void InitializeEnemies() {
  for(int r = 0; r < rows; r++) {  // Scan
    for(int c = 0; c < cols; c++) {
      int cell = minimap[r][c];
      switch(cell) {
        case 1: case 0: break;  // No enemies
        case 2:  // 4 turrets
          
          break;
      }

    }
  }
}
