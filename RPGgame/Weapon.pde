class Weapon {
  // Instance Variables //
  int bulletTimer;
  int firerate;  // Shots per second
  int bulletSpeed;
  
  // Constructor //
  Weapon(int r, int s) {
    bulletTimer = 0;
    firerate = r;
    bulletSpeed = s;
  }
    
  // Update //
  void update() {
    bulletTimer++; 
    
    println(myPlayer.location);
  }
  
  
  // Shoot //
  void shoot() {
    if(bulletTimer >= 60/firerate) {
      PVector aim = new PVector(mouseX-myPlayer.location.x, mouseY-myPlayer.location.y);
      aim.setMag(bulletSpeed);
      myObjects.add(new Bullet(width/2, height/2, aim));
      bulletTimer = 0;
    }
  }
}
