class Weapon {
  // Instance Variables //
  int timer;
  float firerate;  // Shots per second
  float bulletSpeed;
  float size;
  color clr;
  float dmg;
  int index;
  int readyTime;
  int unlocked;
  
  // Constructor //
  Weapon(int index, float firerate, float bulletSpeed, float size, color clr, float dmg) {
    this.index = index;
    this.firerate = firerate;
    this.bulletSpeed = bulletSpeed;
    this.size = size;
    this.clr = clr;
    this.dmg = dmg;
    readyTime = ceil((60/firerate));  // The value of the timer when weapon is ready
    timer = readyTime;
  }
    
    
  // Update //
  void update() {
    if(timer < 60/firerate) timer++; 
  }
  
  
  // Shoot //
  void shoot() {
    if(timer >= 60/firerate) {
      PVector aim = new PVector(mouseX-myPlayer.location.x, mouseY-myPlayer.location.y);
      aim.setMag(bulletSpeed);
      myObjects.add(0, new Bullet("PLAYER", width/2, height/2, size, aim, clr, dmg));
      timer = 0;
    }
  }
  
  
  // Unlocked? //
  void unlocked(int unlocked) {
    this.unlocked = unlocked;  // 1 = true, 0 = false
  }
}
