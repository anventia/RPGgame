void game() {
  background(255);
  
  for(Room i : myRooms) {  // Show rooms
    i.show();
    i.act();
  }
  
  for(gameObject i : myObjects) {
    i.show();
    i.act();
  }
  
  if(keyW) { roomY += speed; }
  if(keyA) { roomX += speed; }
  if(keyS) { roomY -= speed; }
  if(keyD) { roomX -= speed; }
  
}
