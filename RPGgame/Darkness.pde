void darkness() {
 noStroke();
 fill(0, 100);
 for(float y = darknessSize/2; y < height; y += darknessSize) {
   for( float x = darknessSize/2; x < width; x += darknessSize) {
     rect(x,y, darknessSize,darknessSize);
   }
 }
}
