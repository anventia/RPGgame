
// FireRate, speed, size, color, damage //

class BasicGun extends Weapon { 
  BasicGun() {
    super(3, 5, 20, #FFBB0D, 10);
  }
  
}

class Rapid extends Weapon { 
  Rapid() {
    super(10, 5, 10, #FFBB0D, 1);
  }
  
}

class Rifle extends Weapon {
  Rifle() {
    super(1, 10, 20, #3E30E3, 10); 
  }
}

class Shotgun extends Weapon {
  int numShots = 7;
  
  Shotgun() {
    super(1, 7, 10, #3E3E3E, 1);
  }
  
  void shoot() {
    if(bulletTimer >= 60/firerate) {
      for(int i = 0; i < numShots; i++) {
        PVector aim = new PVector(mouseX-myPlayer.location.x, mouseY-myPlayer.location.y);
        aim.setMag(bulletSpeed*random(0.9,1.1));
        aim.rotate(radians(random(-5,5)));
        myObjects.add(0, new Bullet(width/2, height/2, size, aim, clr, dmg));
      }
      bulletTimer = 0;
    }
  }
}
