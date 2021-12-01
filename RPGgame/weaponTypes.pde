
// index, FireRate, speed, size, color, damage //

class BasicGun extends Weapon { 
  BasicGun(int unlocked) {
    super(0, 2, 5, 20, #94F5F2, 5);
    super.checkUnlocked(unlocked);
  }
  
}

class Rapid extends Weapon { 
  Rapid(int unlocked) {
    super(1, 10, 5, 10, #F24084, 1);
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
    super(3, 1.5, 7, 10, #3E3E3E, 1);
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
  boolean attacking = false;  // Don't start new attack when already attacking!
  float angle = 0;
  
  
  Sword(int unlocked) {
    super(4, 1, 5, 75, #6139EA, 5);
    super.checkUnlocked(unlocked);
  }
  
  void update() {
    println(angle);
    super.update();
    if(attacking) {
      pushMatrix();
        translate(myPlayer.location.x, myPlayer.location.y);
        rotate(radians(angle));
        strokeWeight(5*gameScale);
        line(0,0, 0, -myPlayer.rad-size);
      popMatrix();
      angle += 0.5;
      if(angle >= 360) attacking = false;
    }
  }
  
  void shoot() {
    if(timer >= 60/fireRate && !attacking) {
      attacking = true;
      angle = 0;
    }
  }
}
