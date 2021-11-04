class Bullet extends gameObject {
  // Instance Variables //

  
  // Constructor //
  Bullet(float x, float y, PVector vel) {
    location = new PVector(x, y);
    velocity = vel;
    //direction = dir;
  }
  
  
  // Act //
  void act() {
    super.act();
    location.x += objectOffsetX;
    location.y += objectOffsetY;
  }
  
  
  // Show //
  void show() {
    fill(#FFBB0D);
    noStroke();
    circle(location.x,location.y, 20*gameScale);
  }
}
