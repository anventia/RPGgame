class gameObject {
  
  // Instance Variables //
  int lives;
  float size;  // Size (Diameter)
  float rad;  // Size (Radius)
  float speed;
  
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
