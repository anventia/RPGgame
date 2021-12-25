void darkness() {
  /*
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
  */
  
  darknessTraced();
}

void darknessTraced() {
  int tSize = 75;
  ArrayList<ArrayList> points = new ArrayList<ArrayList>();  // Points on darkness cells (Each point in the ArrayList has its own ArrayList)
  
  int pointIndex = 0;
  for(float y = tSize/2; y <= height; y += tSize) {
    for(float x = tSize/2; x < width; x += tSize) {  // Loop through each cell
      
      points.add(new ArrayList<Integer>());  // Add ArrayList<Integer> for tracer of point
      PVector tVel = new PVector(myPlayer.location.x-x, myPlayer.location.y-y).setMag(tSize);
      PVector tLoc = new PVector(x, y);
      
      while(dist(tLoc.x,tLoc.y, myPlayer.location.x, myPlayer.location.y) > tSize) {  // Increment tracer location towards player
        points.get(pointIndex).add(color(get(int(x), int(y))));  // Add color to the ArrayList<Integer>
        tLoc.add(tVel);
        println(pointIndex, tLoc);
        
      }      
      
      pointIndex++;
    }
  }
  
  // Add another identical set of loops here, but it draws the rectangle at each point with a color depending on the color of the location using get();
  
  
}
