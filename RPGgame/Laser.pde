class Laser extends gameObject {
  // Instance Variables //
  boolean up, down, left, right;
  PVector laser;
  float angle;
  PVector rotation;
  
  // Constructor //
  Laser(float angle) {
    location = myPlayer.location.copy();   
    lives = 1;
    this.angle = angle;
    rotation = new PVector();
  }
  
  
  // Act //
  void act() {
    size = 3*gameScale;
    rad = size/2;
    velocity = new PVector(mouseX-myPlayer.location.x, mouseY-myPlayer.location.y);
    velocity.setMag(1);
    rotation = velocity.copy();
    if(angle != -1) velocity.rotate(radians(angle));
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
    if(angle != -1) line(myPlayer.location.x,myPlayer.location.y, location.x,location.y);
    pushMatrix();
      float a = dist(myPlayer.location.x, myPlayer.location.y, mouseX, mouseY);
      float b = dist(myPlayer.location.x, myPlayer.location.y, location.x, location.y);
      float arrow = a < b ? a : b;
      translate(myPlayer.location.x, myPlayer.location.y);
      rotate(rotation.heading());
      switch(myWeapons[myPlayer.selectedWeapon].index) {  // Add animation switching between arrow types (maybe?)
        case 0:  // Basic Gun
          line(arrow,0, arrow-20*gameScale, 20*gameScale);
          line(arrow,0, arrow-20*gameScale, -20*gameScale);
          break;
        case 1:  // Rapid
          line(arrow+30*gameScale,0, arrow+10*gameScale, 15*gameScale);
          line(arrow+30*gameScale,0, arrow+10*gameScale, -15*gameScale);
          
          line(arrow,0, arrow-20*gameScale, 15*gameScale);
          line(arrow,0, arrow-20*gameScale, -15*gameScale);
          
          line(arrow-30*gameScale,0, arrow-50*gameScale, 15*gameScale);
          line(arrow-30*gameScale,0, arrow-50*gameScale, -15*gameScale);
          break;
        case 2:  // Rifle
          line(arrow+20*gameScale,0, arrow, 20*gameScale);
          line(arrow+20*gameScale,0, arrow, -20*gameScale);
          
          line(arrow-20*gameScale,0, arrow, 20*gameScale);
          line(arrow-20*gameScale,0, arrow, -20*gameScale);
          break;
        case 3:  // Shotgun
          if(angle == 5) break;  // Only draw once for the two beams in shotgun mode
          float y = tan(radians(5))*arrow;
          line(arrow,0, arrow-y*gameScale, y*gameScale);
          line(arrow,0, arrow-y*gameScale, -y*gameScale);
          
          arrow += 30;
          y = tan(radians(5))*arrow;
          line(arrow,0, arrow-y*gameScale, y*gameScale);
          line(arrow,0, arrow-y*gameScale, -y*gameScale);
          break;
        case 4:  // Sword
          float c = myWeapons[4].size;
          line(0, 0, c+myPlayer.rad, 0);
          noFill();
          circle(0,0, c*2+myPlayer.size);
          
          line(myPlayer.rad+c/2-20*gameScale, 10*gameScale, myPlayer.rad+c/2, 30*gameScale);
          line(myPlayer.rad+c/2+20*gameScale, 10*gameScale, myPlayer.rad+c/2, 30*gameScale);
          break;
      }
    popMatrix();
  }
}
