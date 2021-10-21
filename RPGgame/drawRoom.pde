class Room {
  
  // Instance Variables //
  float x;
  float y;
  
  // Constructor //
  Room(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  
  // Act //
  void act() {
     
  }
  
  // Show //
  void show() {
    pushMatrix();
      translate(roomX, roomY);
      rectMode(CENTER);
      noStroke();
      fill(roomWall);
      rect(0,0, (roomSize+wallSize*2)*roomScale,(roomSize+wallSize*2)*roomScale);
      fill(roomFloor);
      rect(0,0, (roomSize)*roomScale, (roomSize)*roomScale);
    popMatrix();
  }
}
