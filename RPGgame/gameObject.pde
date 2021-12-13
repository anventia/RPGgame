class gameObject {
  
  // Instance Variables //
  int lives;
  float default_size;
  float size;  // Size (Diameter)
  float rad;  // Size (Radius)
  float speed;
  
  PVector default_location;
  PVector location;
  PVector velocity;
  PVector direction;
  
  int mapRow, mapCol;  // Current room position in map
  
  float dmg;  // Damage (for bullets)
  String type;  // Type (for bullets + items)
  float offsetX, offsetY;  // Offset (for bullets + items)
  
  // Constructor //
  gameObject() {
    
  }
  
  
  // Act //
  void act() {
    location.add(velocity);
  }
  
  
  // Offset // (for bullets and items)
  void offset() {
    // Offset with room //
    if(keyW && upMove)    { offsetY += myPlayer.speed*speedPercentage; }
    if(keyA && leftMove)  { offsetX += myPlayer.speed*speedPercentage; }
    if(keyS && downMove)  { offsetY -= myPlayer.speed*speedPercentage; }
    if(keyD && rightMove) { offsetX -= myPlayer.speed*speedPercentage; } 
  }
  
  // Check if in room with another object //
  boolean roomWith(gameObject obj) {
    return mapRow == obj.mapRow && mapCol == obj.mapCol;
  }
  
  
  // Show //
  void show() {
    stroke(255,0,255);
    strokeWeight(5);
    line(0, location.y, width, location.y);
    line(location.x, 0, location.x, height);
  }
  
}
