class Enemy extends gameObject {
  // Instance Variables //
  color clr;  // Fill
  color stk;  // Stroke
 
  
  // Constructor //
  Enemy(PVector default_location, float default_size, int lives, int mapCol, int mapRow, color clr, color stk) {  // Basic Enemy
    location = new PVector(0,0);
    velocity = new PVector(0,0);
    this.default_location = default_location;
    this.default_size = default_size;
    this.lives = lives;
    this.mapCol = mapCol;
    this.mapRow = mapRow;
    this.clr = clr;
    this.stk = stk;
  }
  
  
  // Act //
  void act() {
    if(mapCol != roomCol || mapRow != roomRow) return;  // Don't show when player is not in room
    location.x = default_location.x+roomX*scale;
    location.y = default_location.y+roomY*scale;
    location.add(velocity);
    size = default_size*gameScale;
    rad = size/2;
  }
  
  
  // Show //
  void show() {
    if(mapCol != roomCol || mapRow != roomRow)  return;  // Don't show when player is not in room
    fill(clr);
    noStroke();
    circle(width/2+location.x, height/2+location.y, size);
    noFill();
    stroke(stk);
    strokeWeight(size/10);
    polygon(width/2+location.x, height/2+location.y, rad, lives); 
  } 
}
