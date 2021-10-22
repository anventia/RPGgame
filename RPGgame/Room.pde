class Room {
  
  // Instance Variables //
  float startX;
  float startY;
  float x;
  float y;
  int tiles;
  float tileSize;
  float tw;
  float th;
  
  // Constructor //
  Room(float x, float y) {
    this.startX = x;
    this.startY = y;
    this.x = x;
    this.y = y;
    
    tw = width;
    th = height;
    
    tiles = 8;
    tileSize = (roomSize*roomScale)/tiles;
  }
  
  
  // Act //
  void act() {
    
    if(tw != width)  { println("updatewidth");   x = startX*scaleX;}  // Detect if window size changes... 
    if(th != height) { println("updateheight"); y = startY*scaleY;}
    
    tw = width;
    th = height;
    tileSize = ((roomSize*roomScale)/tiles);
  }
  
  // Show //
  void show() {
    pushMatrix();
      translate(x+roomX, y+roomY);
      rectMode(CENTER);
      noStroke();
      fill(roomWall);
      rect(0,0, ((roomSize+wallSize*2)*roomScale),((roomSize+wallSize*2)*roomScale));  // Walls
      fill(roomFloor);
      rect(0,0, ((roomSize)*roomScale), ((roomSize)*roomScale));  // Floor
      fill(roomTile);
      float tx = -roomSize/2*roomScale+tileSize/2;
      float ty = -roomSize/2*roomScale+tileSize/2;
      int checkerX = 1;
      for(int i = 0; i < pow(tiles, 2); i++) {
        if(checkerX == 1) rect(tx,ty, tileSize,tileSize);
        checkerX = checkerX*-1;
        tx += tileSize;
        if(tx > roomSize*roomScale/2) {if(tiles % 2 == 0) {checkerX = checkerX*-1;}tx = -roomSize/2*roomScale+tileSize/2; ty += tileSize;}
      }
      
      fill(255,0,255);
      //rect(0,0, 100,100);
      
    popMatrix();
  }
}
