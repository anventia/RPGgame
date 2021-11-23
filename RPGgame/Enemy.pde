class Enemy extends gameObject {
  // Instance Variables //
  color clr;  // Fill
  color stk;  // Stroke
  int bulletTimer;
  int base_lives;
  
  // Constructor //
  Enemy(PVector default_location, float default_size, int lives, int mapCol, int mapRow, color clr, color stk) {  // Basic Enemy
    location = new PVector(0,0);
    velocity = new PVector(0,0);
    this.default_location = default_location;
    this.default_size = default_size;
    this.rad = default_size/2;
    this.lives = lives;
    this.base_lives = lives;
    this.mapCol = mapCol;
    this.mapRow = mapRow;
    this.clr = clr;
    this.stk = stk;
    this.bulletTimer = 0;
  }
  
  
  // Act //
  void act() {
    location.x = default_location.x+roomX*scale;
    location.y = default_location.y+roomY*scale;
    default_location.add(velocity);
    size = default_size*gameScale;
    rad = size/2;
    

    
    // Collide with bullets //
    for(gameObject obj : myObjects) {
      if(obj instanceof Bullet && obj.type.equals("PLAYER")) {
        if(dist(location.x, location.y, obj.location.x, obj.location.y) <= rad+obj.rad) {
          lives -= obj.dmg;
          obj.lives --;
        }
      }
    }
  }
  
  
  // Show //
  void show() {
    fill(clr);
    noStroke();
    circle(location.x, location.y, size);
    noFill();
    stroke(stk);
    strokeWeight(size/10);
    polygon(location.x, location.y, rad*0.8, int(lives)); 
    
    push();  // Health bar
      colorMode(HSB, 360, 100, 100);
      color healthbarColor =  color(map(lives, 0,base_lives, 0,100), 52, 98);
      rectMode(CENTER);
      fill(0);
      stroke(0);
      strokeWeight(3);
      float barX = location.x; float barY = location.y-size/2-10*scale;
      rect(barX,barY, size*1.5, 10*gameScale);
      rectMode(CORNER);
      fill(healthbarColor);
      noStroke();
      rect(barX-size*0.75,barY-5*gameScale, size*1.5*map(lives ,0, base_lives, 0, 1), 10*gameScale);
      //progressBar(0, map(lives, 0, base_lives, 0, 1), location.x, location.y-size/2-10*scale, size*1.5, 5, 2.5, 2, healthbarColor, 100, 50);
    pop();
  } 
}
