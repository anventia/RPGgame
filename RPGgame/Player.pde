class Player extends gameObject {
  
  // Instance Variables //
  Weapon weapon;
  
  // Constructor //
  Player() {
    default_size = 100;
    rad = size/2;
    lives = 1;
    
    mapCol = roomCol;
    mapRow = roomRow;
    
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    
    weapon = new Rifle();
  }
  
  

  
  
  // Act //
  void act() {
    location.x = width/2;
    location.y = height/2;
    size = default_size*gameScale;
    rad = size/2;
    speed = 5*gameScale;
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
