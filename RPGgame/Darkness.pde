void darkness() {
  noStroke();
  for(float y = darknessSize/2; y <= height; y += darknessSize) {
    for( float x = darknessSize/2; x < width; x += darknessSize) {
      fill(0,map(dist(myPlayer.location.x,myPlayer.location.y, x,y), 150*gameScale,900*gameScale, 0, 255 ));
      rect(x,y, darknessSize,darknessSize);
    }
  }
}
