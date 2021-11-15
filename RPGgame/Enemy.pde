class Enemy extends gameObject {
  // Instance Variables //
  color clr;  // Fill
  color stk;  // Stroke
  int bulletTimer;
  
  // Constructor //
  Enemy(PVector default_location, float default_size, int lives, int mapCol, int mapRow, color clr, color stk) {  // Basic Enemy
    location = new PVector(0,0);
    velocity = new PVector(0,0);
    this.default_location = default_location;
    this.default_size = default_size;
    this.rad = default_size/2;
    this.lives = lives;
    this.mapCol = mapCol;
    this.mapRow = mapRow;
    this.clr = clr;
    this.stk = stk;
    this.bulletTimer = 0;
  }
  
  
  // Act //
  void act() {
    if(mapCol != roomCol || mapRow != roomRow) return;  // Don't show when player is not in room
    location.x = default_location.x+roomX*scale;
    location.y = default_location.y+roomY*scale;
    default_location.add(velocity);
    size = default_size*gameScale;
    rad = size/2;
    

    
    // Collide with bullets //
    for(gameObject obj : myObjects) {
      if(obj instanceof Bullet) {
        if(dist(location.x, location.y, obj.location.x, obj.location.y) <= rad+obj.rad) {
          lives -= obj.dmg;
          obj.lives --;
        }
      }
    }
    
    println(lives);
  }
  
  
  // Show //
  void show() {
    if(mapCol != roomCol || mapRow != roomRow)  return;  // Don't show when player is not in room
    fill(clr);
    noStroke();
    circle(location.x, location.y, size);
    noFill();
    stroke(stk);
    strokeWeight(size/10);
    polygon(location.x, location.y, rad*0.8, int(lives)); 
  } 
}
