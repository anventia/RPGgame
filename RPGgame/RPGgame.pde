// RPG Game //



// Variables //

final int INTRO = 0;  // Mode Framework
final int GAME = 1;
int mode;

color roomFloor = 230;  // Colors
color roomWall = #4B48B2;

float wallSize;  // Room values
float roomScale = 1;
float roomSize = 1000;
float roomX, roomY;

ArrayList<Room> myRooms; // ArrayLists
ArrayList<gameObject> myObjects;

float speed = 5;  // Player

void setup() { 
  size(960, 540);
  background(255);
  scaleWindow();
  
  wallSize = 50*scaleX;
  
  roomX = width/2;
  roomY = height/2;
  
  myRooms = new ArrayList<Room>();
  myRooms.add(new Room(width/2, height/2));
  myObjects = new ArrayList<gameObject>();
  myObjects.add(new Player());
  
  
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
