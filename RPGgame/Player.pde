class Player extends gameObject {
  
  // Instance Variables //
  Weapon weapon;
  Weapon[] myWeapons;
  int selectedWeapon;
  
  // Constructor //
  Player() {
    default_size = 100;
    rad = size/2;
    lives = 100;
    
    mapCol = roomCol;
    mapRow = roomRow;
    
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    
    myWeapons = new Weapon[]{
      new BasicGun(),
      new Rapid(),
      new Rifle(),
      new Shotgun()
    };

    selectedWeapon = 0;  // Default weapon: BasicGun
    
  }
  
  

  
  
  // Act //
  void act() {
    location.x = width/2;
    location.y = height/2;
    size = default_size*gameScale;
    rad = size/2;
    mapCol = roomCol;
    mapRow = roomRow;
    speed = 5*gameScale;
    super.act();
    weapon = myWeapons[selectedWeapon];
    
    // Collide with enemy bullets //
    for(gameObject obj : myObjects) {
      if(obj instanceof Bullet && obj.type.equals("TURRET")) {
        if(dist(location.x, location.y, obj.location.x, obj.location.y) <= rad+obj.rad) {
          lives -= obj.dmg;
          obj.lives --;
        }
      }
    }
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
