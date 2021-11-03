void minimap() {
  int pixel;
  float mapX = 30*scale;
  float mapY = 30*scale;
  float px = mapX;
  float py = mapY;
  float ps = 20;  // Size of pixel
  
  
  // Draw map //
  for(int r = 0; r < rows; r++) {  
    for(int c = 0; c < cols; c++) {
      pixel = minimap[r][c];
      if(pixel == 0) fill(100);
      if(pixel == 1) fill(255);
      noStroke();
      rect(px,py, ps,ps);
      px += ps;
    }
    px = mapX;
    py += ps;
  }
  
  
  // Draw location //
  fill(255,0,255);
  float ls = 5;  // Location indicator size
  float lx = mapX+(currentCol-1)*ps + map(roomX*scale, -roomSize/2*roomScale+myPlayer.rad,roomSize/2*roomScale-myPlayer.rad, ps/2-ls/2, -ps/2+ls/2);  // Map location indicator X and Y
  float ly = mapY+(currentRow-1)*ps + map(roomY*scale, -roomSize/2*roomScale+myPlayer.rad,roomSize/2*roomScale-myPlayer.rad, ps/2-ls/2, -ps/2+ls/2);  // to coordinates within minimap
  circle(lx,ly, ls);
  
  
  // Text // 
  fill(255);
  textFont(consolas);
  textSize(15);
  textAlign(CENTER);
  text("row: "+currentRow+" col: "+currentCol, mapX+ps*rows/2-ps/2, mapY+ps*rows+15);
 
}
