class Enemy extends gameObject {
  // Instance Variables //
  color clr;  // Fill
  color stk;  // Stroke
  
  
  // Constructor //
  Enemy() {  // Basic Enemy
    default_location = new PVector(300*gameScale, -300*gameScale);
    default_size = 75;
    lives = 100;
    mapCol = 3;
    mapRow = 3;
    clr = #65E882;
  }
  
  
  // Act //
  void act() {
    location.x = default_location.x+roomX*scale;
    location.y = default_location.y+roomY*scale;
    size = default_size*gameScale;
    rad = size/2;
  }
  
  
  // Show //
  void show() {
    fill(clr);
    noStroke();
    circle(width/2+location.x, height/2+location.y, size);
    noFill();
    stroke(stk);
    polygon(width/2+location.x, height/2+location.y, rad, lives); 
  } 
}
