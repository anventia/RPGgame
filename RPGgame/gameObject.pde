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
   String type;  // Type (for bullets)
  
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
