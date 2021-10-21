void game() {
  background(0);
  
  for(Room i : myRooms) {  // Show rooms
    i.show();
    i.act();
  }
  
  for(gameObject i : myObjects) {  // Show objects
    i.show();
    i.act();
  }
  
  
  // Wall collisions //
  upWall    = (myPlayer.location.y - (height/2+roomY-roomSize/2*scale)) <= myPlayer.rad;
  leftWall  = (myPlayer.location.x - (width/2+roomX-roomSize/2*scale))  <= myPlayer.rad;
  downWall  = ((height/2+roomY+roomSize/2*scale) - myPlayer.location.y) <= myPlayer.rad;
  rightWall = ((width/2+roomX+roomSize/2*scale) - myPlayer.location.x)  <= myPlayer.rad;
  
  upDoor = downDoor = leftDoor = rightDoor = true;  // All 4 directions have doors (testing)
   
   
  // Motion rules //
  upMove = downMove = leftMove = rightMove = false;
  if(upWall && !upDoor) upMove = false;  // Can't move if touching wall with no door
  if((upWall && upDoor) || !upWall)  upMove = true;   // Can move if touching wall with door, or not touching wall
  
  if(downWall && !downDoor) downMove = false;  // Can't move if touching wall with no door
  if((downWall && downDoor) || !downWall)  downMove = true;   // Can move if touching wall with door, or not touching wall
  
  if(leftWall && !leftDoor) leftMove = false;  // Can't move if touching wall with no door
  if((leftWall && leftDoor) || !leftWall)  leftMove = true;   // Can move if touching wall with door, or not touching wall
  
  if(rightWall && !rightDoor) rightMove = false;  // Can't move if touching wall with no door
  if((rightWall && rightDoor) || !rightWall)  rightMove = true;   // Can move if touching wall with door, or not touching wall

   
  // Movement //
  if(keyW && upMove)    { roomY += speed; }
  if(keyA && leftMove)  { roomX += speed; }
  if(keyS && downMove)  { roomY -= speed; }
  if(keyD && rightMove) { roomX -= speed; }
  
  
  // Add new rooms // (To be replaced with doors)
  if(upWall && newRoom == -1 && upDoor) {  // Top 
    newRoom = 0;
    myRooms.add(new Room(width/2, height/2-(roomSize+wallSize*2)*scale));
  }
  
  if(rightWall && newRoom == -1 && rightDoor) {  // Right 
    newRoom = 1;
    myRooms.add(new Room(width/2+(roomSize+wallSize*2)*scale, height/2));
  }
  
  stroke(255);
  strokeWeight(10);
  //line(width/2+roomX, 0, width/2+roomX, height);
  
  switch(newRoom) {
    case 0:  // Top
    
      if(roomY < (roomSize*scale)/2-myPlayer.rad) {myRooms.remove(1); newRoom = -1; break;}
      else if(roomY > ((roomSize*scale)/2+(wallSize*scale)*2+myPlayer.rad)) {  // Remove old room on the bottom
        myRooms.remove(0);
        newRoom = -1;
        println("Test");
        roomY = -((roomSize*scale)/2-myPlayer.rad);  // Set new room to main room
        myRooms.get(0).y = height/2;
      } break;
      
    case 1:  // Right
      if(roomX < -((roomSize*scale)/2+(wallSize*scale)*2+myPlayer.rad)) {  // Remove old room on the left
        myRooms.remove(0);
        newRoom = -1;
        
        roomX = (roomSize*scale)/2-myPlayer.rad;  // Set new room to main room
        myRooms.get(0).x = width/2;
      } break;
  }
  
  // if(keyQ) {myRooms.add(new Room(width/2+roomX+(roomSize+wallSize*2)*scale, height/2+roomY));}
  
  circle(height/2, width/2+(roomSize+wallSize*2)*scale, 100);
} 
