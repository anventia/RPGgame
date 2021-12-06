
// index, FireRate, speed, size, color, damage //

class BasicGun extends Weapon { 
  BasicGun(int unlocked) {
    super(0, 2, 5, 40, #94F5F2, 5);
    super.checkUnlocked(unlocked);
  }
  
}

class Rapid extends Weapon { 
  Rapid(int unlocked) {
    super(1, 10, 5, 20, #F24084, 1);
    super.checkUnlocked(unlocked);
  }
  
}

class Rifle extends Weapon {
  Rifle(int unlocked) {
    super(2, 1, 20, 20, #3E30E3, 10); 
    super.checkUnlocked(unlocked);
  }
}

class Shotgun extends Weapon {
  int numBullets = 7;  // Number of bullets to fire per shot
  
  Shotgun(int unlocked) {
    super(3, 1.5, 7, 15, #3E3E3E, 1);
    super.checkUnlocked(unlocked);
  }
  
  void shoot() {
    if(timer >= 60/fireRate) {
      for(int i = 0; i < numBullets; i++) {
        PVector aim = new PVector(mouseX-myPlayer.location.x, mouseY-myPlayer.location.y);
        aim.setMag(bulletSpeed*random(0.9,1.1));
        aim.rotate(radians(random(-5,5)));
        myObjects.add(0, new Bullet("PLAYER", width/2, height/2, size, aim, clr, dmg));
      }
      timer = 0;
    }
  }
}

class Sword extends Weapon {
  float startangle;
  float angle;
  
  Sword(int unlocked) {
    super(4, 0.3, 5, 75, #000000, 5);
    super.checkUnlocked(unlocked);
    attacking = false;
    increment = 15;  // Swing speed
  }
  
  void sword() {
    if(attacking) {
      pushMatrix();
        translate(myPlayer.location.x, myPlayer.location.y);
        rotate(radians(angle)+startangle);
        strokeWeight(5*gameScale);
        stroke(clr);
        line(0,0, myPlayer.rad+size,0);
      popMatrix();
      angle += increment;  // Swing sword
      myObjects.add(0, new swordBlur(radians(angle)+startangle));
      if(angle > 360) attacking = false;
      
      swordPoint = new PVector[] {  // Multiple points along the sword to detect enemy collisions
        new PVector(width/2+(myPlayer.rad+size)*cos(radians(angle)+startangle), height/2+(myPlayer.rad+size)*sin(radians(angle)+startangle)),
        new PVector(width/2+(myPlayer.rad+size/2)*cos(radians(angle)+startangle), height/2+(myPlayer.rad+size/2)*sin(radians(angle)+startangle))
      };

    }
  }
  
  void shoot() {
    if(timer >= 60/fireRate && !attacking) {
      attacking = true;
      startangle = atan2((mouseY-height/2), (mouseX-width/2));
      angle = 0;
      timer = 0;
    }
  }
}

class swordBlur extends gameObject {  // Blur effect for sword swing
  float increment;  // Angle per frame (equal to swingSpeed)
  float alpha;  // Transparency
  float angle;  // Start angle
  
  swordBlur(float angle) {
    default_location = new PVector(width/2, height/2);
    this.increment = myWeapons[4].increment;
    this.angle = angle;
    offsetX = offsetY = 0;
    location = myPlayer.location.copy();
    alpha = 200;
    lives = 1;
    mapCol = myPlayer.mapCol;
    mapRow = myPlayer.mapRow;
  }
  
  
  // Act //
  void act() {
    super.offset();
    location.x = default_location.x+offsetX*scale;
    location.y = default_location.y+offsetY*scale;
    
    alpha -= 10;
    if(alpha <= 0) lives = 0;
  }
  
  
  // Show //
  void show() {
    fill(#555555, alpha);
    noStroke();
    arc(location.x, location.y, (myPlayer.rad+myWeapons[4].size)*2, (myPlayer.rad+myWeapons[4].size)*2, angle-(radians(increment)*2), angle-radians(increment));    
  }
  
}
