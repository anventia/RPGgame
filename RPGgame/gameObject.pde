class gameObject {
  
  // Instance Variables //
  int lives;
  float size;
  
  PVector location;
  PVector velocity;
  PVector direction;
  
  
  // Constructor //
  gameObject() {
    
  }
  
  
  // Act //
  void act() {
    location.add(velocity);
  }
  
  
  // Show //
  void show() {
    
  }
  
}
