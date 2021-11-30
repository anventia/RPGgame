class Item extends gameObject {
  // Instance Variables //
  int addIndex;  // Weapon index for weapon items
   
  // Constructor //
  Item(String type, float x, float y, int mapCol, int mapRow) {
    location = new PVector(0,0);
    this.default_location = new PVector(x,y);
    this.type = type;
    this.mapCol = mapCol;
    this.mapRow = mapRow;
    default_size = type == "WEAPON" ? 100 : 50;
    lives = 1;
    if(type == "WEAPON") {  // Add a random weapon!
       for(int i = 0; i < myPlayer.myWeapons.length; i++) {
         addIndex = int(random(0, myPlayer.myWeapons.length));
         if(myPlayer.myWeapons[addIndex].unlocked == 1) continue;
         break;
       }
    }
  }
  
  
  // Act //
  void act() {
    super.offset();
    location.x = default_location.x+offsetX*scale;
    location.y = default_location.y+offsetY*scale;
    size = default_size*gameScale;
    rad = size/2;
    
    // Collide with player //
    if(dist(location.x, location.y, myPlayer.location.x, myPlayer.location.y) < rad+myPlayer.rad) {  // Detect collision
      switch(type) {  // Different result for different item types
        case "WEAPON":
          lives = 0;
          if(myPlayer.myWeapons[addIndex].unlocked == 0) {  // Not unlocked -> unlock it
            myPlayer.myWeapons[addIndex].unlocked = 1;
          } else {  // Already unlocked, refresh ammunition???
            
          }
          return;
        case "HEALTH":
          lives = 0;
          myPlayer.lives = myPlayer.lives+healAmount > maxHealth ? maxHealth : myPlayer.lives+healAmount;  // Adds HP, but doesn't go over maximum health
          return;
      }
    }
  }
  
  
  // Show //
  void show() {
    strokeWeight(5*gameScale);
    fill(type == "WEAPON" ? iWeapon : iHealth);
    stroke(type == "WEAPON" ? iWeapon_s : iHealth_s);
    circle(location.x, location.y, size);
    switch(type) {  // Draw icons
      case "WEAPON":
        PImage icon = gunIcons[addIndex];
        imageMode(CENTER);
        image(icon, location.x, location.y, size, size);
        break;
    }
  }
}
