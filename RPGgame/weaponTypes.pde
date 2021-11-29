
// index, FireRate, speed, size, color, damage //

class BasicGun extends Weapon { 
  BasicGun(int unlocked) {
    super(0, 3, 5, 20, #94F5F2, 10);
    super.unlocked(unlocked);
  }
  
}

class Rapid extends Weapon { 
  Rapid(int unlocked) {
    super(1, 10, 5, 10, #F24084, 1);
    super.unlocked(unlocked);
  }
  
}

class Rifle extends Weapon {
  Rifle(int unlocked) {
    super(2, 1, 20, 20, #3E30E3, 10); 
    super.unlocked(unlocked);
  }
}

class Shotgun extends Weapon {
  int numShots = 7;
  
  Shotgun(int unlocked) {
    super(3, 1.5, 7, 10, #3E3E3E, 1);
    super.unlocked(unlocked);
  }
  
  void shoot() {
    if(timer >= 60/firerate) {
      for(int i = 0; i < numShots; i++) {
        PVector aim = new PVector(mouseX-myPlayer.location.x, mouseY-myPlayer.location.y);
        aim.setMag(bulletSpeed*random(0.9,1.1));
        aim.rotate(radians(random(-5,5)));
        myObjects.add(0, new Bullet("PLAYER", width/2, height/2, size, aim, clr, dmg));
      }
      timer = 0;
    }
  }
}
