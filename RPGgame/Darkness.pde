void darkness() {
  ///*
  noStroke();
  ArrayList<Integer> pxColors = new ArrayList<Integer>();
  
  
  // get pixels //
  for(float y = darknessSize/2; y <= height; y += darknessSize) {
    for( float x = darknessSize/2; x < width; x += darknessSize) {
      color clr = get(int(x),int(y));
      pxColors.add(clr);
    }
  }
  println(color(roomWall));  
  
  int pxIndex = 0;
  for(float y = darknessSize/2; y <= height; y += darknessSize) {
    for( float x = darknessSize/2; x < width; x += darknessSize) {
      
      fill(0,map(dist(myPlayer.location.x,myPlayer.location.y, x,y), 150*gameScale,900*gameScale, 0, 255 ));  // Transparency based on distance to player
      
      float ang = ((atan((height/2-y)+(width/2-x))));
      PVector lineV = new PVector(x-myPlayer.location.x, y-myPlayer.location.y).setMag(5);
      PVector lineL = myPlayer.location.copy();
      
      //while(!(pxColors.get(pxIndex) == color(roomWall))) {  // While the pixel is not
        
      //}
      
      rect(x,y, darknessSize,darknessSize);
      pxIndex++;
    }
  }
  //*/
  
  darknessTraced();
}

void darknessTraced() {  // better "raytracing" light effect without raytracing???
  fill(0);
  noStroke();
  pushMatrix();
    translate(width/2+roomX*scale, height/2+roomY*scale);
    float pX = -roomX;
    float pY = -roomY;
    
    // UP DOOR //
    if(pY >= -roomSize*gameScale/2-wallSize) {
      beginShape(); // Left
        vertex(-doorSize/2, -roomSize*gameScale/2-wallSize);
        vertex(-roomSize*gameScale/2-wallSize, -roomSize*gameScale/2-wallSize);
        vertex(-roomSize*gameScale/2-wallSize, -roomSize*gameScale*1.5-wallSize);
        vertex((-doorSize/2-pX)/((-roomSize*gameScale/2-wallSize)-pY)*((-roomSize*gameScale*1.5-wallSize)-(roomSize*gameScale/2+wallSize)), -roomSize*gameScale*1.5-wallSize);
        vertex(-doorSize/2, -roomSize*gameScale/2-wallSize);
      endShape();
      
      beginShape(); // Right
        vertex(doorSize/2, -roomSize*gameScale/2-wallSize);
        vertex(roomSize*gameScale/2+wallSize, -roomSize*gameScale/2-wallSize);
        vertex(roomSize*gameScale/2+wallSize, -roomSize*gameScale*1.5-wallSize);
        vertex((doorSize/2-pX)/((-roomSize*gameScale/2-wallSize)-pY)*((-roomSize*gameScale*1.5-wallSize)-(roomSize*gameScale/2+wallSize)), -roomSize*gameScale*1.5-wallSize);
        vertex(doorSize/2, -roomSize*gameScale/2-wallSize);
      endShape();
    }
    
    
    // DOWN DOOR //
    if(pY <= roomSize*gameScale/2+wallSize) {
      beginShape(); // Left
        vertex(-doorSize/2, roomSize*gameScale/2+wallSize);
        vertex(-roomSize*gameScale/2-wallSize, roomSize*gameScale/2+wallSize);
        vertex(-roomSize*gameScale/2-wallSize, roomSize*gameScale*1.5+wallSize);
        vertex((-doorSize/2-pX)/((roomSize*gameScale/2+wallSize)-pY)*((roomSize*gameScale*1.5+wallSize)-(roomSize*gameScale/2+wallSize)), roomSize*gameScale*1.5+wallSize);
        vertex(-doorSize/2, roomSize*gameScale/2+wallSize);
      endShape();
      
      beginShape(); // Right
        vertex(doorSize/2, roomSize*gameScale/2+wallSize);
        vertex(roomSize*gameScale/2+wallSize, roomSize*gameScale/2+wallSize);
        vertex(roomSize*gameScale/2+wallSize, roomSize*gameScale*1.5+wallSize);
        vertex((doorSize/2-pX)/((roomSize*gameScale/2+wallSize)-pY)*((roomSize*gameScale*1.5+wallSize)-(roomSize*gameScale/2+wallSize)), roomSize*gameScale*1.5+wallSize);
        vertex(doorSize/2, roomSize*gameScale/2+wallSize);
      endShape();
    }
    
    
    // LEFT DOOR //
    if(pX >= -roomSize*gameScale/2-wallSize) {
      beginShape();  // Top
        vertex(-roomSize*gameScale/2-wallSize, -doorSize/2);
        vertex(-roomSize*gameScale/2-wallSize, -roomSize*gameScale/2-wallSize);
        vertex(-roomSize*gameScale*1.5-wallSize, -roomSize*gameScale/2-wallSize);
        vertex(-roomSize*gameScale*1.5-wallSize, (-doorSize/2-pY)/((-roomSize*gameScale/2-wallSize)-pX)*((-roomSize*gameScale*1.5-wallSize)-(-roomSize*gameScale/2-wallSize)));
        vertex(-roomSize*gameScale/2-wallSize, -doorSize/2);
      endShape();
      
     beginShape();  // Bottom
        vertex(-roomSize*gameScale/2-wallSize, doorSize/2);
        vertex(-roomSize*gameScale/2-wallSize, roomSize*gameScale/2+wallSize);
        vertex(-roomSize*gameScale*1.5-wallSize, roomSize*gameScale/2+wallSize);
        vertex(-roomSize*gameScale*1.5-wallSize, (doorSize/2-pY)/((-roomSize*gameScale/2-wallSize)-pX)*((-roomSize*gameScale*1.5-wallSize)-(-roomSize*gameScale/2-wallSize)));
        vertex(-roomSize*gameScale/2-wallSize, doorSize/2);
      endShape();
    }
    
    
    // RIGHT DOOR //
    if(pX <= roomSize*gameScale/2+wallSize) {
      beginShape();  // Top
        vertex(roomSize*gameScale/2+wallSize, -doorSize/2);
        vertex(roomSize*gameScale/2+wallSize, -roomSize*gameScale/2-wallSize);
        vertex(roomSize*gameScale*1.5+wallSize, -roomSize*gameScale/2-wallSize);
        vertex(roomSize*gameScale*1.5+wallSize, (-doorSize/2-pY)/((roomSize*gameScale/2+wallSize)-pX)*((roomSize*gameScale*1.5+wallSize)-(roomSize*gameScale/2+wallSize)));
        vertex(roomSize*gameScale/2+wallSize, -doorSize/2);
      endShape();
      
     beginShape();  // Bottom
        vertex(roomSize*gameScale/2+wallSize, doorSize/2);
        vertex(roomSize*gameScale/2+wallSize, roomSize*gameScale/2+wallSize);
        vertex(roomSize*gameScale*1.5+wallSize, roomSize*gameScale/2+wallSize);
        vertex(roomSize*gameScale*1.5+wallSize, (doorSize/2-pY)/((roomSize*gameScale/2+wallSize)-pX)*((roomSize*gameScale*1.5+wallSize)-(roomSize*gameScale/2+wallSize)));
        vertex(roomSize*gameScale/2+wallSize, doorSize/2);
      endShape();
    }
    
    
    
  popMatrix();
}


void darknessTraced_broken() {  // "raytracing" effect (does not work!!!)
  int tSize = 20;
  ArrayList<ArrayList> points = new ArrayList<ArrayList>();  // Points on darkness cells (Each point in the ArrayList has its own ArrayList)
  PVector tVel, tLoc;
  rectMode(CENTER);
  for(int l = 0; l < 2; l++) {  // Repeat twice
    int pointIndex = 0;
    for(float y = tSize/2; y <= height; y += tSize) {
      for(float x = tSize/2; x < width; x += tSize) {  // Loop through each cell
        if(l == 0) {  // First loop: Get colors
          tLoc = new PVector(x, y);
          tVel = new PVector(myPlayer.location.x-x, myPlayer.location.y-y).setMag(tSize);
          points.add(new ArrayList<Integer>());  // Add ArrayList<Integer> for tracer of point
          while(dist(tLoc.x,tLoc.y, myPlayer.location.x, myPlayer.location.y) > tSize) {  // Increment tracer location towards player
            points.get(pointIndex).add(color(get(int(x), int(y))));  // Add color to the ArrayList<Integer>
            tLoc.add(tVel);
          } 
        } else {  // Second loop: Set rectangles
          tLoc = new PVector(myPlayer.location.x, myPlayer.location.y);
          tVel = new PVector(x-myPlayer.location.x, y-myPlayer.location.y).setMag(tSize);
          int clrIndex = 0;
          color fill = 255;
          //fill(255,0,0);
          //rect(x, y, tSize,tSize);
          while(dist(tLoc.x,tLoc.y, x, y) > tSize) {  // Increment tracer location from player towards location
            //points.get(pointIndex).add(color(get(int(x), int(y))));  // Add color to the ArrayList<Integer>
            if((int)(points.get(pointIndex).get(clrIndex)) == (int)-11843406) {
              fill = 0;  // For some reason, this fills it to 0 for one square, then it fills to 255 again... Instead of it being 0 for the remaining squares outward.
            }           
            fill(fill);
            rect(tLoc.x, tLoc.y, tSize,tSize);
            tLoc.add(tVel);
            clrIndex++;
          } 
        }
        pointIndex++;
      }
    }
  }  
}
