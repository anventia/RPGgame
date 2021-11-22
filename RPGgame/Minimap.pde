void minimap() {
  int pixel;
  float mapX = 30*scale;
  float mapY = 30*scale;
  float px = mapX;
  float py = mapY;
  float ps = 20;  // Size of pixel
  
  
  // Draw map //
  for(int r = 0; r < rows; r++) {  // Scan 
    for(int c = 0; c < cols; c++) {
      pixel = minimap[r][c];
      fill( pixel == 0 ? 100 : 255 );  // pixel == 0 => no room, fill grey. else, there's a room, fill white  
      strokeWeight(1);
      rect(px,py, ps,ps);
      px += ps;
    }
    px = mapX;
    py += ps;
  }
  
  
  // Draw location //
  fill(255,0,255);
  noStroke();
  float ls = 5;  // Location indicator size
  float lx = mapX+(roomCol-1)*ps + map(roomX*scale, -roomSize/2*gameScale+myPlayer.rad,roomSize/2*gameScale-myPlayer.rad, ps/2-ls/2, -ps/2+ls/2);  // Map location indicator X and Y
  float ly = mapY+(roomRow-1)*ps + map(roomY*scale, -roomSize/2*gameScale+myPlayer.rad,roomSize/2*gameScale-myPlayer.rad, ps/2-ls/2, -ps/2+ls/2);  // to coordinates within minimap
  circle(lx,ly, ls);
  
  
  // Text // 
  fill(255);
  textFont(consolas);
  textSize(15);
  textAlign(CENTER);
  text("row: "+roomRow+" col: "+roomCol, mapX+ps*rows/2-ps/2, mapY+ps*rows+15);
  
 
}
