class Player extends gameObject {
  
  // Instance Variables //

  
  // Constructor //
  Player() {
    size = 60*roomScale;
    rad = size/2;
    speed = 10*roomScale;
    
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
  }
  
  
  // Act //
  void act() {
    location.x = width/2;
    location.y = height/2;
    size = 60*roomScale;
    rad = size/2;
    speed = 10*roomScale;
    super.act();
  }
  
  
  // Show //
  void show() {
    pushMatrix();
      translate(location.x, location.y);
      noStroke();
      fill(240,100,150);
      circle(0,0, size);
    popMatrix();
  }
}
