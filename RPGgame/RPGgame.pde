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

// Player
  

// Game
boolean leftWall, rightWall, upWall, downWall;  // true if touching wall
boolean leftDoor, rightDoor, upDoor, downDoor;  // true if door exists
boolean leftMove, rightMove, upMove, downMove;  // true if can move in that direction
int newRoom = -1;
float darknessSize;


void setup() { 
  size(960, 540);
  background(255);
  scaleWindow();
  surface.setResizable(true);
  
  defaultroomScale = 0.5;
  defaultwallSize = 100;
  defaultdoorSize = 200;
  
  roomX = 0;
  roomY = 0;
  
  darknessSize = 5;
  
  myRooms = new ArrayList<Room>();
  myRooms.add(new Room(0,0));
  myObjects = new ArrayList<gameObject>();
  myPlayer = new Player();
  myObjects.add(myPlayer);
  tempRooms = new ArrayList<Room>();
  
  mode = GAME;
}

void draw() {
  detectClicks();
  scaleWindow();
  switch(mode) {  // Mode Framework
    case INTRO: intro(); break;
    case GAME:  game();  break;
  }
}
