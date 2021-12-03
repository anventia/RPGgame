class Laser extends gameObject {
  // Instance Variables //
  boolean up, down, left, right;
  PVector laser;
  
  // Constructor //
  Laser() {
    location = myPlayer.location.copy();
    
    
    lives = 1;
  }
  
  
  // Act //
  void act() {
    size = 2*gameScale;
    rad = size/2;
    velocity = new PVector(mouseX-myPlayer.location.x, mouseY-myPlayer.location.y);
    velocity.setMag(5);
    location = myPlayer.location.copy();
    laser = location.copy();
    mapCol = myPlayer.mapCol;
    mapRow = myPlayer.mapRow;
    
    detect();
    while(!up && !down && !left && !right) {  // Finds final point touching wall
      laser.add(velocity);
      detect();
    }
    
    location = laser.copy();
  }
  
  void detect() {  // Detects wall
    up    = (laser.y - (height/2+roomY*scale-roomSize/2*gameScale)) <= rad;
    left  = (laser.x - (width/2+roomX*scale-roomSize/2*gameScale))  <= rad;
    down  = ((height/2+roomY*scale+roomSize/2*gameScale) - laser.y) <= rad;
    right = ((width/2+roomX*scale+roomSize/2*gameScale) - laser.x)  <= rad; 
  }
  
  
  // Show //
  void show() {
    stroke(255,0,0);
    strokeWeight(size);
    line(myPlayer.location.x,myPlayer.location.y, location.x,location.y);
  }
}
