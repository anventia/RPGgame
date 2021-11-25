class Bullet extends gameObject {
  // Instance Variables //
  float positionX;  // Location with offset
  float positionY;
  color clr;
  
  // Constructor //
  Bullet(String type, float x, float y, float size, PVector vel, color clr, float dmg) {
    default_location = new PVector(x, y);
    location = new PVector(0,0);
    velocity = vel;
    //velocity.add(myRooms.get(0).velocity.copy());
    offsetX = offsetY = 0;
    default_size = size;
    this.clr = clr;
    lives = 1;
    mapCol = myPlayer.mapCol;
    mapRow = myPlayer.mapRow;
    this.dmg = dmg;
    this.type = type;
  }
  
  
  // Act //
  void act() {
    
    location.x = default_location.x+offsetX*scale;
    location.y = default_location.y+offsetY*scale;
    default_location.add(velocity);
    this.size = default_size*gameScale;
    rad = size/2;  // radius
    
    
    
    super.offset();
    
    //positionX = (location.x*scale)+offsetX*scale;
   // positionY = (location.y*scale)+offsetY*scale;
    
    // Collide with walls //
    if((location.y - (height/2+roomY*scale-roomSize/2*gameScale)) <= rad) { lives = 0; }
    if((location.x - (width/2+roomX*scale-roomSize/2*gameScale))  <= rad) { lives = 0; }
    if(((height/2+roomY*scale+roomSize/2*gameScale) - location.y) <= rad) { lives = 0; }
    if(((width/2+roomX*scale+roomSize/2*gameScale) - location.x)  <= rad) { lives = 0; }
  }
  
  
  // Show //
  void show() {
    fill(clr);
    noStroke();
    circle(location.x, location.y, size);
  }
}
