class Weapon {
  // Instance Variables //
  int bulletTimer;
  float firerate;  // Shots per second
  float bulletSpeed;
  float size;
  color clr;
  float dmg;
  
  // Constructor //
  Weapon(float firerate, float bulletSpeed, float size, color clr, float dmg) {
    bulletTimer = 0;
    this.firerate = firerate;
    this.bulletSpeed = bulletSpeed;
    this.size = size;
    this.clr = clr;
    this.dmg = dmg;
  }
    
  // Update //
  void update() {
    bulletTimer++; 
    
  }
  
  
  // Shoot //
  void shoot() {
    if(bulletTimer >= 60/firerate) {
      PVector aim = new PVector(mouseX-myPlayer.location.x, mouseY-myPlayer.location.y);
      aim.setMag(bulletSpeed);
      myObjects.add(0, new Bullet("PLAYER", width/2, height/2, size, aim, clr, dmg));
      bulletTimer = 0;
    }
  }
}
