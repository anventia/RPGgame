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
      translate(x+roomX, y+roomY);
      rectMode(CENTER);
      noStroke();
      fill(roomWall);
      rect(0,0, (roomSize+wallSize*2)*scale,(roomSize+wallSize*2)*scale);
      fill(roomFloor);
      rect(0,0, (roomSize)*scale, (roomSize)*scale);
    popMatrix();
  }
}
