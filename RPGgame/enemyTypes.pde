class Follower extends Enemy {
  Follower(float x, float y, int mapCol, int mapRow) {
    super(
      new PVector(width/2+x, height/2+y),  // Location
      75,  // Size
      10,  // Lives
      mapCol,  // Map Column
      mapRow,  // Map Row
      #65E882,  // Color
      #0BE037  // Stroke Color
    );
  }
  
  void act() {
    velocity = new PVector(myPlayer.location.x-location.x, myPlayer.location.y-location.y);
    velocity.setMag(1);
    super.act();
    
    if(lives < 1 && int(random(0,100)) <75) {  // Drop weapon item 3/4 of the time
      myObjects.add(new Item("HEALTH", location.x, location.y, mapCol, mapRow));
    }
  }
}

class Turret extends Enemy {
  int bulletSpeed = 5;
  
  Turret(float x, float y, int mapCol, int mapRow) {
    super(
      new PVector(width/2+x, height/2+y),  // Location
      100,  // Size
      25,  // Lives
      mapCol,  // Map Column
      mapRow,  // Map Row
      #FCC436,  // Color
      #E5B12C  // Stroke Color
    );
    
  }
  
  // Act //
  void act() {
    super.act();
    bulletTimer++;
    if(bulletTimer > 60) {  // Shoot
      bulletTimer = 0;
      PVector aim = new PVector(myPlayer.location.x-location.x, myPlayer.location.y-location.y);  // FIX
      aim.setMag(bulletSpeed);
      myObjects.add(0, new Bullet("TURRET", location.x, location.y, 15, aim, clr, 4));
      bulletTimer = 0;
    }
    
    if(lives < 1 && int(random(0,100)) >50) {  // Drop weapon item 1/2 of the time
      myObjects.add(new Item("WEAPON", location.x, location.y, mapCol, mapRow));
    }
  }
}
