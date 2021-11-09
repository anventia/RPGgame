class Bullet extends gameObject {
  // Instance Variables //
  float offsetX;  // Offset with room
  float offsetY;
  float positionX;  // Location with offset
  float positionY;
  color clr;
  
  // Constructor //
  Bullet(float x, float y, float size, PVector vel, color clr) {
    location = new PVector(x, y);
    velocity = vel;
    velocity.add(myRooms.get(0).velocity.copy());
    offsetX = offsetY = 0;
    this.size = size;
    rad = size/2;  // radius
    this.clr = clr;
    lives = 1;
  }
  
  
  // Act //
  void act() {
    super.act();
    
    // Offset with room //
    if(keyW && upMove)    { offsetY += myPlayer.speed; }
    if(keyA && leftMove)  { offsetX += myPlayer.speed; }
    if(keyS && downMove)  { offsetY -= myPlayer.speed; }
    if(keyD && rightMove) { offsetX -= myPlayer.speed; }
    
    positionX = (location.x*scale)+offsetX*scale;
    positionY = (location.y*scale)+offsetY*scale;
    
    // Collide with walls //
    if((positionY - (height/2+roomY*scale-roomSize/2*gameScale)) <= rad) { lives = 0; }
    if((positionX - (width/2+roomX*scale-roomSize/2*gameScale))  <= rad) { lives = 0; }
    if(((height/2+roomY*scale+roomSize/2*gameScale) - positionY) <= rad) { lives = 0; }
    if(((width/2+roomX*scale+roomSize/2*gameScale) - positionX)  <= rad) { lives = 0; }
  }
  
  
  // Show //
  void show() {
    fill(clr);
    noStroke();
    circle(positionX, positionY, size*gameScale);
  }
}
