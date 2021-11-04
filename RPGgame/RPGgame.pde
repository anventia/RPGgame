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
float defaultwallSize;
float roomScale;
float defaultroomScale;
float roomSize = 1000;
float roomX, roomY;
float doorSize;
float defaultdoorSize;

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
int currentRow, currentCol;

// Font
PFont consolas;

void setup() { 
  size(960, 540);
  background(255);
  scaleWindow();
  surface.setResizable(true);
  
  // Mode Framework
  mode = GAME;
  
  // Room values
  defaultroomScale = 0.5;
  defaultwallSize = 50;
  defaultdoorSize = 200;
  roomX = 0;
  roomY = 0;
  
  // Objects
  myRooms = new ArrayList<Room>();
  myRooms.add(new Room(0,0, -2));
  myObjects = new ArrayList<gameObject>();
  myPlayer = new Player();
  myObjects.add(myPlayer);
  tempRooms = new ArrayList<Room>();
  
   // Game
  darknessSize = 5;
  rows = 8;
  cols = 8;
  minimap = new int[][]{  // Initialize map
    {0,0,0,0,0,0,0,0},
    {0,0,0,0,1,1,1,0},
    {0,0,1,1,1,1,1,0},  // To add: 0 = wall, 1 = room
    {0,0,1,0,0,1,1,0},  // other numbers = rounded corners
    {0,1,1,0,0,1,0,0},  // Rounded corners: wall < 0 < room
    {0,1,1,1,1,1,0,0},
    {0,1,1,1,0,0,0,0},
    {0,0,0,0,0,0,0,0}
  };
  currentRow = 3;
  currentCol = 3;
  
  // Font
  consolas = createFont("Consolas", 1);
  
}

void draw() {
  detectClicks();
  scaleWindow();
  switch(mode) {  // Mode Framework
    case INTRO: intro(); break;
    case GAME:  game();  break;
  }
}
