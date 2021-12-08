class Player extends gameObject {
  // Instance Variables //
  Weapon weapon;
  int selectedWeapon;
  int immunityTimer;
  
  
  // Constructor //
  Player() {
    default_size = 100;
    rad = size/2;
    lives = maxHealth;
    mapCol = roomCol;
    mapRow = roomRow;
    
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);

    selectedWeapon = 0;  // Default weapon: BasicGun
    immunityTimer = 0;
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
    immunityTimer++;
    
    // Collide with enemy bullets //
    for(int i = 0; i < myObjects.size(); i++) {
      gameObject obj = myObjects.get(i);
      if(obj instanceof Bullet && obj.type.equals("TURRET")) {
        if(dist(location.x, location.y, obj.location.x, obj.location.y) <= rad+obj.rad) {
          damage(obj.dmg);
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
      if(immunityTimer <= 40) {  // Immune
        noFill();
        stroke(0);
        strokeWeight(10*gameScale);
        circle(0,0, size*1.5);
      }
    popMatrix();
  }
  
  
  // Take Damage //
  void damage(float amount) {
    if(immunityTimer > 40) {
      lives -= amount;
      myObjects.add(new Message("DAMAGE", "-"+amount, location.x, location.y, 45*gameScale, #C12F2F));
      immunityTimer = 0;
    }
  }
}
