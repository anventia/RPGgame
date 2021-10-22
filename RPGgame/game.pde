void game() {
  background(0);
  
  wallSize = 100*roomScale;
  roomScale = defaultroomScale*scale;
  
  for(Room i : myRooms) {  // Show rooms
    i.show();
    i.act();
  }
  
  for(gameObject i : myObjects) {  // Show objects
    i.show();
    i.act();
  }
  
  
  // Wall collisions //
  upWall    = (myPlayer.location.y - (height/2+roomY-roomSize/2*roomScale)) <= myPlayer.rad;
  leftWall  = (myPlayer.location.x - (width/2+roomX-roomSize/2*roomScale))  <= myPlayer.rad;
  downWall  = ((height/2+roomY+roomSize/2*roomScale) - myPlayer.location.y) <= myPlayer.rad;
  rightWall = ((width/2+roomX+roomSize/2*roomScale) - myPlayer.location.x)  <= myPlayer.rad;
  
  
  // Box ... 
  stroke(0,255,255);
  strokeWeight(5);
  line((width/2+roomX-roomSize/2*roomScale),(height/2+roomY-roomSize/2*roomScale), (width/2+roomX+roomSize/2*roomScale),(height/2+roomY-roomSize/2*roomScale));
  line((width/2+roomX+roomSize/2*roomScale),(height/2+roomY-roomSize/2*roomScale), (width/2+roomX+roomSize/2*roomScale),(height/2+roomY+roomSize/2*roomScale));
  line((width/2+roomX+roomSize/2*roomScale),(height/2+roomY+roomSize/2*roomScale), (width/2+roomX-roomSize/2*roomScale),(height/2+roomY+roomSize/2*roomScale));
  line((width/2+roomX-roomSize/2*roomScale),(height/2+roomY+roomSize/2*roomScale), (width/2+roomX-roomSize/2*roomScale),(height/2+roomY-roomSize/2*roomScale));
  line(width/2+roomX,height/2+roomY, width/2,height/2);
  
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
  if(keyW && upMove)    { roomY += myPlayer.speed; }
  if(keyA && leftMove)  { roomX += myPlayer.speed; }
  if(keyS && downMove)  { roomY -= myPlayer.speed; }
  if(keyD && rightMove) { roomX -= myPlayer.speed; }
  
  // println(rightWall+" - "+newRoom+" - "+rightDoor);
  
  // Add new rooms // (To be replaced with doors)
  if(upWall && newRoom == -1 && upDoor) {  // Top 
    newRoom = 0;
    myRooms.add(new Room(width/2, height/2-((roomSize+wallSize*2)*roomScale)));
  }
  
  if(rightWall && newRoom == -1 && rightDoor) {  // Right 
    newRoom = 1;
    println(newRoom);
    myRooms.add(new Room(width/2+((roomSize+wallSize*2)*roomScale), height/2));
  }
  
  if(downWall && newRoom == -1 && downDoor) {  // Bottom 
    newRoom = 2;
    myRooms.add(new Room(width/2, height/2+((roomSize+wallSize*2)*roomScale)));
  }
  
  if(leftWall && newRoom == -1 && leftDoor) {  // Left 
    newRoom = 3;
    myRooms.add(new Room(width/2-((roomSize+wallSize*2)*roomScale), height/2));
  }
  
  
  // Remove unneeded rooms //
  switch(newRoom) {
    case 0:  // Top
      if(roomY < (roomSize*roomScale)/2-myPlayer.rad) {myRooms.remove(1); newRoom = -1; break;}
      else if(roomY > ((roomSize*roomScale)/2+(wallSize*roomScale)*2+myPlayer.rad)) {  // Remove old room on the bottom
        myRooms.remove(0);
        newRoom = -1;
        roomY = (-((roomSize*roomScale)/2-myPlayer.rad));  // Set new room to main room
        myRooms.get(0).startY = height/2;
        println("TOP");
      } break;
      
    case 1:  // Right
      if(roomX > -((roomSize*roomScale)/2-myPlayer.rad)) {myRooms.remove(1); newRoom = -1; break;}
      else if(roomX < -((roomSize*roomScale)/2+(wallSize*roomScale)*2+myPlayer.rad)) {  // Remove old room on the left
        myRooms.remove(0);
        newRoom = -1;
        roomX = ((roomSize*roomScale)/2-myPlayer.rad);  // Set new room to main room
        myRooms.get(0).startX = width/2;
        println("RIGHT");
      } break;
      
    case 2:  // Bottom
      if(roomY > -((roomSize*roomScale)/2-myPlayer.rad)) {myRooms.remove(1); newRoom = -1; break;}
      else if(roomY < -((roomSize*roomScale)/2+(wallSize*roomScale)*2+myPlayer.rad)) {  // Remove old room on the bottom
        myRooms.remove(0);
        newRoom = -1;
        roomY = ((roomSize*roomScale)/2-myPlayer.rad);  // Set new room to main room
        myRooms.get(0).startY = height/2;
        println("BOT");
      } break;
      
    case 3:  // Left
      if(roomX < (roomSize*roomScale)/2-myPlayer.rad) {myRooms.remove(1); newRoom = -1; break;}
      else if(roomX > ((roomSize*roomScale)/2+(wallSize*roomScale)*2+myPlayer.rad)) {  // Remove old room on the left
        myRooms.remove(0);
        newRoom = -1;
        roomX = -((roomSize*roomScale)/2-myPlayer.rad);  // Set new room to main room
        myRooms.get(0).startX = width/2;
        println("LEFT");
      } break;
  }
  
  
} 
