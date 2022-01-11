// RPG Game //
 

// Variables //

// Mode Framework
final int INTRO = 0;  
final int GAME = 1;
int mode;
boolean paused;
boolean pauseMenu;
boolean gameOver;

// Colors
color debug = #FF00FF;
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

// Game
boolean leftWall, rightWall, upWall, downWall;  // true if touching wall
boolean leftDoor, rightDoor, upDoor, downDoor;  // true if door exists
boolean leftMove, rightMove, upMove, downMove;  // true if can move in that direction
int newRoom;
PVector tempRoom, tempRoom2;
boolean InTempRoom, InTempRoom2;
float darknessSize;  // Size of darkness pixels
int[][] minimap;  // Minimap array
int rows, cols;
int roomRow, roomCol;
float inSize, inOffset; // Weapon indicator
float slY, slTargetY, default_slSpeed, slSpeed;  // Weapon selector
PVector healAmount;  // Item healing amount min/max
int maxHealth;  // Player maximum lives
float speedPercentage;  // Player speed multiplier
float damagePercentage;  // Player damage multiplier
int money;  // Number of points to spend
boolean[] buttonHover;
float fade;
int numEnemies;

// Objects
ArrayList<Room> myRooms; 
ArrayList<Room> tempRooms;
ArrayList<Room> sideRooms;
ArrayList<gameObject> myObjects;
ArrayList<gameObject> lasers;
Weapon[] myWeapons;
Player myPlayer;
gameObject offset;

// Font
PFont consolas;

// Icons
PImage[] gunIcons;
PImage[] otherIcons;

// Other
boolean debugconsole;

void setup() { 
  frameRate(60);
  size(960, 540, FX2D);
  background(255);
  scaleWindow();

  // Room values
  roomSize = 1000;
  default_roomScale = 0.5;
  default_wallSize = 50;
  default_doorSize = 300;
   
  // Game
  tempRoom = new PVector(0,0);
  tempRoom2 = new PVector(0,0);
  darknessSize = 5;
  rows = 8;
  cols = 8;
  minimap = new int[][] {  // Initialize map
    {0,0,0,0,0,0,0,0},
    {0,0,0,0,2,3,5,0},
    {0,0,1,3,3,4,2,0},  
    {0,0,2,0,0,3,2,0},   
    {0,2,2,0,0,3,0,0},  
    {0,3,3,4,6,2,0,0},
    {0,5,5,3,0,0,0,0},
    {0,0,0,0,0,0,0,0}
  };
  default_slSpeed = slSpeed = 10;
  inSize = 75*scale;  // Indicator size
  inOffset = 20*scale;  // Indicator offset 
  healAmount = new PVector(2, 6);
  buttonHover = new boolean[] {  // Is mouse hovering over buttons
    false,  // 0: Left pause button
    false,  // 1: Middle pause button
    false,  // 2: Right pause button
    false   // 3: Intro screen button
  };  
  
  // Font
  consolas = createFont("Consolas", 1);
  
  // Icons
  gunIcons = new PImage[] {
    loadImage("basic_gun.png"),
    loadImage("rapid.png"),
    loadImage("rifle.png"),
    loadImage("shotgun.png"),
    loadImage("sword.png")
  };
  otherIcons = new PImage[] {
    loadImage("damage.png"),
    loadImage("heart.png"),
    loadImage("speed.png")
  };
  
  
  initialize();
}


void draw() {
  detectClicks();
  scaleWindow();
  switch(mode) {  // Mode Framework
    case INTRO: intro(); break;
    case GAME:  game();  break;
  }
}


void initialize() {  // Set up game
  // Mode Framework
  mode = INTRO;
  paused = false;
  pauseMenu = false;
  gameOver = false;
  
  // Room values
  roomX = 0;
  roomY = 0;
  
  // Game
  roomRow = 3;  // Starting room
  roomCol = 3;
  slTargetY = inSize/2+inOffset;  // Start on first (default) weapon
  maxHealth = 100;
  speedPercentage = 1;
  damagePercentage = 1;
  money = 0;
  newRoom = -1;
  
  // Objects
  myRooms   = new ArrayList<Room>();
  myObjects = new ArrayList<gameObject>();
  tempRooms = new ArrayList<Room>();
  sideRooms = new ArrayList<Room>(); 
  lasers    = new ArrayList<gameObject>();
  offset    = new Offset();
  myWeapons = new Weapon[] {  // 1 = unlocked, 0 = locked.  -> Set all to 1 to unlock them all at the start to try all the weapons
    new BasicGun(1),
    new Rapid(0),
    new Rifle(0),
    new Shotgun(0),
    new Sword(0)
  };
  myPlayer  = new Player();
  myRooms.add(new Room(0,0, -2));
  lasers.add(new Laser(0));
  lasers.add(new Laser(-5));
  lasers.add(new Laser(5));
  lasers.add(new Laser(-1));
  myObjects.add(myPlayer);
  sideRooms.add(new Room(0, -1));
  sideRooms.add(new Room(1 , 0));
  sideRooms.add(new Room(0, 1));
  sideRooms.add(new Room(-1, 0));
  
  // Enemies
  InitializeEnemies();
}


// Spawn enemies //
void InitializeEnemies() {
  for(int r = 1; r <= rows; r++) {  // Scan matrix
    for(int c = 1; c <= cols; c++) {
      int cell = minimap[r-1][c-1];
      switch(cell) {
        case 0: case 1: break;  // No enemies
        case 2:  // 4 turrets
          myObjects.add(new Turret(-200,-200, c,r));
          myObjects.add(new Turret(200,-200, c,r));
          myObjects.add(new Turret(-200,200, c,r));
          myObjects.add(new Turret(200,200, c,r));
          break;
        case 3:  // Followers
          for(int i = 0; i < 10; i++) myObjects.add(new Follower(random(-100,100), random(-100,100), c,r));
          break;
        case 4: // Spawner
          myObjects.add(new Spawner(0,0, c,r));
          break;
        case 5:  // Spawner + Turrets
          myObjects.add(new Spawner(0,0, c,r));
          myObjects.add(new Turret(-100,-100, c,r));
          myObjects.add(new Turret(100,100, c,r));
          break;
        case 6:  // Two spawners
          myObjects.add(new Spawner(0, 150, c,r));
          myObjects.add(new Spawner(0, -150, c,r));
      }
    }
  }
}
