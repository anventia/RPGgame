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

// Room valuesaa
float wallSize;  
float defaultwallSize;
float roomScale;
float defaultroomScale;
float roomSize = 1000;
float roomX, roomY;

// Objects
ArrayList<Room> myRooms; 
ArrayList<gameObject> myObjects;
Player myPlayer;

// Player
  

// Game
boolean leftWall, rightWall, upWall, downWall;  // true if touching wall
boolean leftDoor, rightDoor, upDoor, downDoor;  // true if door exists
boolean leftMove, rightMove, upMove, downMove;  // true if can move in that direction
int newRoom = -1;

void setup() { 
  size(960, 540);
  background(255);
  scaleWindow();
  surface.setResizable(true);
  
  defaultroomScale = 0.5;
  roomScale = 0.5;
  defaultwallSize = 100;
  wallSize = 100;
  
  roomX = 0;
  roomY = 0;
  
  
  myRooms = new ArrayList<Room>();
  myRooms.add(new Room(width/2, height/2));
  myObjects = new ArrayList<gameObject>();
  myPlayer = new Player();
  myObjects.add(myPlayer);
  
  
  mode = GAME;
}

void draw() {
  if(keyQ) { keyQ = false; defaultroomScale += 0.1; }
  //println(roomScale);
  detectClicks();
  scaleWindow();
  switch(mode) {  // Mode Framework
    case INTRO: intro(); break;
    case GAME:  game();  break;
  }
}
