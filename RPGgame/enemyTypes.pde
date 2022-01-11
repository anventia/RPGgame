class Follower extends Enemy {
  float vMag;
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
    vMag = random(0.5, 2);
  }
  
  void act() {
    velocity = new PVector(myPlayer.location.x-location.x, myPlayer.location.y-location.y);
    velocity.setMag(vMag);
    location.x = default_location.x*scale+roomX*scale;
    location.y = default_location.y*scale+roomY*scale;
    
    if(location.y <= height/2+roomY-roomSize*gameScale/2+rad) {  // Collide with walls (and not get stuck on them)
      if(location.y > myPlayer.location.y) default_location.sub(velocity); else default_location.add(velocity);
    } else if(location.y >= height/2+roomY+roomSize*gameScale/2-rad) {
      if(location.y < myPlayer.location.y) default_location.sub(velocity); else default_location.add(velocity);
    } else if(location.x <= width/2+roomX-roomSize*gameScale/2+rad) {
      if(location.x > myPlayer.location.x) default_location.sub(velocity); else default_location.add(velocity);
    } else if(location.x >= width/2+roomX+roomSize*gameScale/2-rad) {  
      if(location.x < myPlayer.location.x) default_location.sub(velocity); else default_location.add(velocity);
    } else {
      super.act();
    }
    
    if(dist(location.x, location.y, myPlayer.location.x, myPlayer.location.y) <= myPlayer.rad+rad) {  // Deal damage to player when touching it
      myPlayer.damage(15);
    }
    
    if(lives < 1 && int(random(0,100)) <75) {  // Drop weapon item 3/4 of the time
      myObjects.add(new Item("HEALTH", location.x, location.y, mapCol, mapRow));
      money += int(random(1,7));
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
    location.x = default_location.x*scale+roomX*scale;
    location.y = default_location.y*scale+roomY*scale;
    super.act();
    bulletTimer++;
    if(bulletTimer > 60) {  // Shoot
      bulletTimer = 0;
      PVector aim = new PVector(myPlayer.location.x-location.x, myPlayer.location.y-location.y);  // FIX
      aim.setMag(bulletSpeed);
      myObjects.add(0, new Bullet("TURRET", location.x, location.y, 15, aim, clr, 4));
      bulletTimer = 0;
    }
    
    if(lives < 1 && int(random(0,100)) >66) {  // Drop weapon item 1/3 of the time
      myObjects.add(new Item("WEAPON", location.x, location.y, mapCol, mapRow));
      money += 20;
    }
  }
}

class Spawner extends Enemy {
  
  Spawner(float x, float y, int mapCol, int mapRow) {
    super(
      new PVector(width/2+x, height/2+y),  // Location
      200,  // Size
      300,  // Lives
      mapCol,  // Map Column
      mapRow,  // Map Row
      #7654E8,  // Color
      #6A48DE  // Stroke Color
    );
    
  }
  
  // Act //
  void act() {
    location.x = default_location.x*scale+roomX*scale;
    location.y = default_location.y*scale+roomY*scale;
    super.act();
    bulletTimer++;
    if(bulletTimer > map(lives, 300,0, 100, 20)) {  // Spawn follower (spawns more often if HP is lower 
      bulletTimer = 0;
      myObjects.add(0, new Follower(width/2-location.x+roomX+random(-100,100)*gameScale, height/2-location.y+roomY+random(-100,100)*gameScale, mapCol, mapRow));
      bulletTimer = 0;
    }
    
    
    if(dist(location.x, location.y, myPlayer.location.x, myPlayer.location.y) <= myPlayer.rad+rad) {  // Deal damage to player when touching it
      myPlayer.damage(25);
    }
    
    if(lives < 1 && int(random(0,100)) >50) {  // Drop weapon item 1/2 of the time
      myObjects.add(new Item("WEAPON", location.x, location.y, mapCol, mapRow));
      money += 100;
    }
  }
}
