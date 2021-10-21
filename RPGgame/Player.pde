class Player extends gameObject {
  
  // Instance Variables //
  
  
  // Constructor //
  Player() {
    size = 60;
    
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
  }
  
  
  // Act //
  void act() {
    super.act();
  }
  
  
  // Show //
  void show() {
    pushMatrix();
      translate(location.x, location.y);
      noStroke();
      fill(0);
      circle(0,0, size);
    popMatrix();
  }
}
