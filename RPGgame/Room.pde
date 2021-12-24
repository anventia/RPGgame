class Room {
  
  // Instance Variables //
  PVector velocity;
  float x;
  float y;
  int tiles;
  float tileSize;
  float tw;
  float th;
  String fade;
  float fadeCount;
  float lives;
  boolean isTemporary;
  int newRoom;
 
  
  // Constructor //
  Room(float x, float y, int newRoom) {
    velocity = new PVector(0,0);
    this.x = x;
    this.y = y;
    lives = 1;
    
    tw = width;
    th = height;
    
    fade = "in";
    fadeCount = 0;
    
    this.newRoom = newRoom;
    
    tiles = 10;
    tileSize = (roomSize*gameScale)/tiles;
  }
  
  Room(float x, float y, float c, int newRoom, String fade) {  // Alternate constructor for temporary rooms
    this.x = x;
    this.y = y;
    lives = 1;
    
    tw = width;
    th = height;
    
    this.fade = fade;
    fadeCount = c;
    
    isTemporary = true;
    this.newRoom = newRoom;
    
    tiles = 10;
    tileSize = (roomSize*gameScale)/tiles;
  }
  
  
  // Act //
  void act() {    
    tw = width;
    th = height;
    tileSize = (roomSize*gameScale)/tiles;
    wallSize = default_wallSize*gameScale;
    
    if(fade.equals("in")) fadeCount++;
    if(fade.equals("out")) fadeCount --;
    if(fadeCount == 30) fade = "off";
    if(fadeCount == -1) {fade = "off"; lives = 0;}
    
  }
  
  
  // Show //
  void show() {
    pushMatrix();
      translate(width/2+x+roomX*scale, height/2+y+roomY*scale);
      rectMode(CENTER);
      noStroke();
      fill(roomWall);
      rect(0,0, (roomSize*gameScale+wallSize*2),(roomSize*gameScale+wallSize*2));  // Walls
      fill(roomFloor);
      rect(0,0, ((roomSize)*gameScale), ((roomSize)*gameScale));  // Floor
      fill(roomTile);
      float tx = -roomSize/2*gameScale+tileSize/2;
      float ty = -roomSize/2*gameScale+tileSize/2;
      int checkerX = 1;
      for(int i = 0; i < pow(tiles, 2); i++) {  // Checkerboard floor
        if(checkerX == 1) rect(tx,ty, tileSize,tileSize);
        checkerX = checkerX*-1;
        tx += tileSize;
        if(tx > roomSize*gameScale/2) { if(tiles % 2 == 0) {checkerX = checkerX*-1;}tx = -roomSize/2*gameScale+tileSize/2; ty += tileSize; }
      }  
    popMatrix();
  }
  
  
  // Fade (temp. rooms) //
  void fade() {
    fill(0,map(fadeCount, 0,30, 255,0));
    noStroke();
      if(newRoom != -2) {  // Draws rectangle for 'fade' effect (different orientation depending on which side the  
        pushMatrix();
          translate(width/2+x+roomX*scale, height/2+y+roomY*scale);
          rectMode(CENTER);
          switch(newRoom) {
            case 1: case 3: rotate(radians(90)); break;  // Left and right rotate 90°
          }
          rect(0,0, (roomSize*gameScale+wallSize*2),(roomSize*gameScale));  
        popMatrix();
      } else { rect(0,0, (roomSize*gameScale+wallSize*2),(roomSize*gameScale+wallSize*2)); }  // Starting room fade effect id -2
  }
  
}
