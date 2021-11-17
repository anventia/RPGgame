class Weapon {
  // Instance Variables //
  int timer;
  float firerate;  // Shots per second
  float bulletSpeed;
  float size;
  color clr;
  float dmg;
  String name;
  
  // Constructor //
  Weapon(String name, float firerate, float bulletSpeed, float size, color clr, float dmg) {
    timer = 0;
    this.name = name;
    this.firerate = firerate;
    this.bulletSpeed = bulletSpeed;
    this.size = size;
    this.clr = clr;
    this.dmg = dmg;
  }
    
  // Update //
  void update() {
    timer++; 
    
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
}
