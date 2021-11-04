class Player extends gameObject {
  
  // Instance Variables //
  float defaultSize = 100;
  Weapon weapon;
  
  // Constructor //
  Player() {
    size = defaultSize*gameScale;
    rad = size/2;
    speed = 10*gameScale;
    
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    
    weapon = new BasicGun();
  }
  
  

  
  
  // Act //
  void act() {
    location.x = width/2;
    location.y = height/2;
    size = defaultSize*gameScale;
    rad = size/2;
    speed = 10*gameScale;
    super.act();
    
    
  }
  
  
  // Show //
  void show() {
    pushMatrix();
      translate(location.x, location.y);
      noStroke();
      fill(240,100,150);
      circle(0,0, size);
      //rect(0,0, size,size);
    popMatrix();
  }
}
