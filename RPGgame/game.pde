void game() {
  background(0);
  
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
  upWall    = (myPlayer.location.y - (height/2+roomY*scale-roomSize/2*roomScale)) <= myPlayer.rad;
  leftWall  = (myPlayer.location.x - (width/2+roomX*scale-roomSize/2*roomScale))  <= myPlayer.rad;
  downWall  = ((height/2+roomY*scale+roomSize/2*roomScale) - myPlayer.location.y) <= myPlayer.rad;
  rightWall = ((width/2+roomX*scale+roomSize/2*roomScale) - myPlayer.location.x)  <= myPlayer.rad;
  
  
  strokeWeight(5);
   /*
  stroke(0,255,255); // width/2+(100*scale)+roomX*scale
  
  line((width/2+roomX*scale-roomSize/2*roomScale),(height/2+roomY*scale-roomSize/2*roomScale), (width/2+roomX*scale+roomSize/2*roomScale),(height/2+roomY*scale-roomSize/2*roomScale));
  line((width/2+roomX*scale+roomSize/2*roomScale),(height/2+roomY*scale-roomSize/2*roomScale), (width/2+roomX*scale+roomSize/2*roomScale),(height/2+roomY*scale+roomSize/2*roomScale));
  line((width/2+roomX*scale+roomSize/2*roomScale),(height/2+roomY*scale+roomSize/2*roomScale), (width/2+roomX*scale-roomSize/2*roomScale),(height/2+roomY*scale+roomSize/2*roomScale));
  line((width/2+roomX*scale-roomSize/2*roomScale),(height/2+roomY*scale+roomSize/2*roomScale), (width/2+roomX*scale-roomSize/2*roomScale),(height/2+roomY*scale-roomSize/2*roomScale));
  line(width/2+roomX*scale,height/2+roomY*scale, width/2,height/2);
  // */

  /*
  noFill();
  stroke(255,255,0);
  rect(width/2, height/2, 540*scale, 540*scale);
  
  stroke(255,0,255);
  rect(width/2+(100*scale)+roomX*scale, height/2+(100*scale)+roomY*scale, 100*scale,100*scale);
  
  // */
  
  // Doors //
  upDoor = downDoor = leftDoor = rightDoor = true;  // All 4 directions have doors (testing)
  // Todo: add fixed-size doors, and only enter new room when touching door
  // - lock player lateral position within door width when passing through door
  // - fade in/out effect when adding/removing rooms 
  
   
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
  
   //println(rightWall+" - "+newRoom+" - "+rightDoor);
  
  // Add new rooms // (To be replaced with doors)
  if(upWall && newRoom == -1 && upDoor) {  // Top 
    newRoom = 0;
    myRooms.add(new Room(0, -(roomSize*roomScale+wallSize)));
  }
  
  if(rightWall && newRoom == -1 && rightDoor) {  // Right
    newRoom = 1;
    myRooms.add(new Room((roomSize*roomScale+wallSize), 0));
  }
  
  if(downWall && newRoom == -1 && downDoor) {  // Bottom 
    newRoom = 2;
    myRooms.add(new Room(0, (roomSize*roomScale+wallSize)));
  }
  
  if(leftWall && newRoom == -1 && leftDoor) {  // Left 
    newRoom = 3;
    myRooms.add(new Room(-(roomSize*roomScale+wallSize), 0));
  }
  
  
  
  
  // Remove unneeded rooms //  TODO: Make adding new rooms (and correctly deleting old ones) work with larger window // ===========================================================================
  switch(newRoom) {
    case 0:  // Top
      if(roomY*scale < (roomSize*roomScale)/2-myPlayer.rad) {myRooms.remove(1); newRoom = -1; break;}  // Remove new room if player doesn't enter it
      else if(roomY*scale > (myPlayer.rad+wallSize+roomSize*roomScale/2)) {  // Remove old room on the bottom
        myRooms.remove(0);
        newRoom = -1;
        roomY = -roomY+(myPlayer.size+wallSize)/scale;  // Set new room to main room
        //myRooms.get(0).startY = 0;
        myRooms.get(0).y = 0;
      } break;
      
    case 1:  // Right =========================================
      if(roomX*scale > -((roomSize*roomScale)/2-myPlayer.rad)) {println("e"+random(1,2)); myRooms.remove(1); newRoom = -1; break;}  // Remove new room if player doesn't enter it
      else if(roomX*scale < -(myPlayer.rad+wallSize+roomSize*roomScale/2)) {  // Remove old room on the left
        myRooms.remove(0);
        println("A");
        newRoom = -1;
        roomX = -roomX-(myPlayer.size+wallSize)/scale;  // Set new room to mai room
        //myRooms.get(0).startX = 0;
        myRooms.get(0).x = 0;  
      } break;
      
    case 2:  // Bottom
      if(roomY*scale > -1*((roomSize*roomScale)/2-myPlayer.rad)) {myRooms.remove(1); newRoom = -1; break;}  // Remove new room if player doesn't enter it
      else if(roomY*scale < -(myPlayer.rad+wallSize+roomSize*roomScale/2)) {  // Remove old room on the bottom
        myRooms.remove(0);
        newRoom = -1;
        roomY = -roomY-(myPlayer.size+wallSize)/scale;  // Set new room to main room
        //myRooms.get(0).startY = 0;
        myRooms.get(0).y = 0;
      } break;
      
    case 3:  // Left
      if(roomX*scale < (roomSize*roomScale)/2-myPlayer.rad) {myRooms.remove(1); newRoom = -1; break;}  // Remove new room if player doesn't enter it
      else if(roomX*scale > (myPlayer.rad+wallSize+roomSize*roomScale/2)) {  // Remove old room on the left
        myRooms.remove(0);
        newRoom = -1;
        roomX = -roomX+(myPlayer.size+wallSize)/scale;  // Set new room to main room
        //myRooms.get(0).startX = 0;
        myRooms.get(0).x = 0;
      } break;
  }
  
  
} 
