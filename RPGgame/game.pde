void game() {
  background(0);

  gameScale = default_roomScale*scale;
  doorSize = default_doorSize*gameScale;
  
  
  // Rooms //
  for(Room i : myRooms) {  // Show rooms
    i.show();
    i.act();
  }
    
  for(int i = 0; i < tempRooms.size(); i++) {  // Temoporary rooms
    Room obj = tempRooms.get(i);
    obj.show();
    obj.act();
    if(obj.lives == 0) tempRooms.remove(i);
  }
  
  
  // Doors //
  upDoor = downDoor = leftDoor = rightDoor = false;
  if(minimap[roomRow-2][roomCol-1] != 0) upDoor = true;
  if(minimap[roomRow][roomCol-1] != 0) downDoor = true;
  if(minimap[roomRow-1][roomCol-2] != 0) leftDoor = true;
  if(minimap[roomRow-1][roomCol] != 0) rightDoor = true;
  
  pushMatrix();
    translate(width/2+roomX*scale, height/2+roomY*scale);
    rotate(radians(0));
    if(upDoor) door();
    rotate(radians(90));
    if(rightDoor) door();
    rotate(radians(90));
    if(downDoor) door();
    rotate(radians(90));
    if(leftDoor) door();
  popMatrix();
 
  
  // GameObjects //
  for(int i = 0; i < myObjects.size(); i++) {
    gameObject obj = myObjects.get(i);
    if(!obj.roomWith(myPlayer) && (obj instanceof Enemy || obj instanceof Bullet)) continue;
    obj.act();
    obj.show();
    if(obj.lives <= 0) myObjects.remove(i);
  }
  
  
  noFill();
  strokeWeight(5);
  stroke(255,0,255);
  //rect(width/2+(100*scale)+roomX*scale, height/2+(100*scale)+roomY*scale, 100*scale,100*scale);
  
  
  // Wall collisions //
  upWall    = (myPlayer.location.y - (height/2+roomY*scale-roomSize/2*gameScale)) <= myPlayer.rad;
  leftWall  = (myPlayer.location.x - (width/2+roomX*scale-roomSize/2*gameScale))  <= myPlayer.rad;
  downWall  = ((height/2+roomY*scale+roomSize/2*gameScale) - myPlayer.location.y) <= myPlayer.rad;
  rightWall = ((width/2+roomX*scale+roomSize/2*gameScale) - myPlayer.location.x)  <= myPlayer.rad;
     
 
  // Motion rules // - Can move if touching door, or not touching wall

  upMove = downMove = leftMove = rightMove = false;
  if(upWall && !upDoor) upMove = false;  // Can't move if touching wall with no door
  if((upWall && upDoor && roomX*scale < doorSize/2 && roomX*scale > -(doorSize/2) && dist(myPlayer.location.x,myPlayer.location.y, width/2+roomX*scale-doorSize/2, height/2+roomY*scale-roomSize*gameScale/2) > myPlayer.rad &&  dist(myPlayer.location.x,myPlayer.location.y, width/2+roomX*scale+doorSize/2, height/2+roomY*scale-roomSize*gameScale/2) > myPlayer.rad) || !upWall)  upMove = true;   // Can move if touching door, or not touching wall
  if(((leftWall && leftDoor) || (rightWall && rightDoor)) && !(roomY*scale < doorSize/2-myPlayer.rad )) upMove = false;  // Restricts movement inside door
  
  if(downWall && !downDoor) downMove = false;  // Can't move if touching wall with no door
  if((downWall && downDoor && roomX*scale < doorSize/2 && roomX*scale > -(doorSize/2) && dist(myPlayer.location.x,myPlayer.location.y, width/2+roomX*scale-doorSize/2, height/2+roomY*scale+roomSize*gameScale/2) > myPlayer.rad &&  dist(myPlayer.location.x,myPlayer.location.y, width/2+roomX*scale+doorSize/2, height/2+roomY*scale+roomSize*gameScale/2) > myPlayer.rad) || !downWall)  downMove = true;   // Can move if touching door, or not touching wall
  if(((leftWall && leftDoor) || (rightWall && rightDoor)) && !(roomY*scale > -(doorSize/2-myPlayer.rad))) downMove = false;  // Restricts movement inside door
  
  if((leftWall && !leftDoor)) leftMove = false;  // Can't move if touching wall with no door
  if((leftWall && leftDoor && roomY*scale < doorSize/2 && roomY*scale > -(doorSize/2) && dist(myPlayer.location.x, myPlayer.location.y, width/2+roomX*scale-roomSize*gameScale/2, height/2+roomY*scale-doorSize/2) > myPlayer.rad && dist(myPlayer.location.x, myPlayer.location.y, width/2+roomX*scale-roomSize*gameScale/2, height/2+roomY*scale+doorSize/2) > myPlayer.rad) || !leftWall)  leftMove = true;   // Can move if touching door, or not touching wall
  if(((upWall && upDoor) || (downWall && downDoor)) && !(roomX*scale < doorSize/2-myPlayer.rad )) leftMove = false;  // Restricts movement inside door
  
  if(rightWall && !rightDoor) rightMove = false;  // Can't move if touching wall with no door
  if((rightWall && rightDoor && roomY*scale < doorSize/2 && roomY*scale > -(doorSize/2) && dist(myPlayer.location.x, myPlayer.location.y, width/2+roomX*scale+roomSize*gameScale/2, height/2+roomY*scale-doorSize/2) > myPlayer.rad && dist(myPlayer.location.x, myPlayer.location.y, width/2+roomX*scale+roomSize*gameScale/2, height/2+roomY*scale+doorSize/2) > myPlayer.rad) || !rightWall)  rightMove = true;   // Can move if touching door, or not touching wall
  if(((upWall && upDoor) || (downWall && downDoor)) && !(roomX*scale > -(doorSize/2-myPlayer.rad))) rightMove = false;  // Restricts movement inside door


   
  // Movement //
  myRooms.get(0).velocity = new PVector(0,0);
  if(keyW && upMove)    { roomY += myPlayer.speed; myRooms.get(0).velocity.y = -myPlayer.speed; }
  if(keyA && leftMove)  { roomX += myPlayer.speed; myRooms.get(0).velocity.x = -myPlayer.speed; }
  if(keyS && downMove)  { roomY -= myPlayer.speed; myRooms.get(0).velocity.y = myPlayer.speed; }
  if(keyD && rightMove) { roomX -= myPlayer.speed; myRooms.get(0).velocity.x = myPlayer.speed; }
  
  
  // Add new rooms // 
  if(upWall && newRoom == -1 && upDoor) {  // Top 
    newRoom = 0;
    myRooms.add(new Room(0, -(roomSize*gameScale+wallSize), newRoom));
  }
  
  if(rightWall && newRoom == -1 && rightDoor) {  // Right
    newRoom = 1;
    myRooms.add(new Room((roomSize*gameScale+wallSize), 0, newRoom));
  }
  
  if(downWall && newRoom == -1 && downDoor) {  // Bottom 
    newRoom = 2;
    myRooms.add(new Room(0, (roomSize*gameScale+wallSize), newRoom));
  }
  
  if(leftWall && newRoom == -1 && leftDoor) {  // Left 
    newRoom = 3;
    myRooms.add(new Room(-(roomSize*gameScale+wallSize), 0, newRoom));
  }
  
  
  // Remove unneeded rooms // 
  switch(newRoom) {
    case 0:  // Top
      if(roomY*scale < (roomSize*gameScale)/2-myPlayer.rad) {myRooms.remove(1); newRoom = -1; break;}  // Remove new room if player doesn't enter it
      else if(roomY*scale > (myPlayer.rad+wallSize+roomSize*gameScale/2)) {  // Remove old room on the bottom [ENTER NEW ROOM: TOP]
        tempRooms.add(new Room(myRooms.get(0).x,myRooms.get(0).y+roomSize*gameScale+wallSize, 30, newRoom));
        tempRooms.get(0).fade = "out";  // Temporary room for fade-out effect
        myRooms.remove(0);
        newRoom = -1;
        roomY = -roomY+(myPlayer.size+wallSize)/scale;  // Set new room to main room
        myRooms.get(0).y = 0;
        roomRow -= 1;  // Move current room up
      } break;
      
    case 1:  // Right
      if(roomX*scale > -((roomSize*gameScale)/2-myPlayer.rad)) {myRooms.remove(1); newRoom = -1; break;}  // Remove new room if player doesn't enter it
      else if(roomX*scale < -(myPlayer.rad+wallSize+roomSize*gameScale/2)) {  // Remove old room on the left [ENTER NEW ROOM: RIGHT]
        tempRooms.add(new Room(myRooms.get(0).x-roomSize*gameScale-wallSize,myRooms.get(0).y, 30, newRoom));
        tempRooms.get(0).fade = "out";  // Temporary room for fade-out effect
        myRooms.remove(0);
        newRoom = -1;
        roomX = -roomX-(myPlayer.size+wallSize)/scale;  // Set new room to main room
        myRooms.get(0).x = 0;  
        roomCol += 1;  // Move current room right
      } break;
      
    case 2:  // Bottom
      if(roomY*scale > -1*((roomSize*gameScale)/2-myPlayer.rad)) {myRooms.remove(1); newRoom = -1; break;}  // Remove new room if player doesn't enter it
      else if(roomY*scale < -(myPlayer.rad+wallSize+roomSize*gameScale/2)) {  // Remove old room on the top [ENTER NEW ROOM: BOTTOM]
        tempRooms.add(new Room(myRooms.get(0).x,myRooms.get(0).y-roomSize*gameScale-wallSize, 30, newRoom));
        tempRooms.get(0).fade = "out";  // Temporary room for fade-out effect
        myRooms.remove(0);
        newRoom = -1;
        roomY = -roomY-(myPlayer.size+wallSize)/scale;  // Set new room to main room
        myRooms.get(0).y = 0;
        roomRow += 1;  // Move current room down
      } break;
      
    case 3:  // Left
      if(roomX*scale < (roomSize*gameScale)/2-myPlayer.rad) {myRooms.remove(1); newRoom = -1; break;}  // Remove new room if player doesn't enter it
      else if(roomX*scale > (myPlayer.rad+wallSize+roomSize*gameScale/2)) {  // Remove old room on the right [ENTER NEW ROOM: LEFT]
        tempRooms.add(new Room(myRooms.get(0).x+roomSize*gameScale+wallSize,myRooms.get(0).y, 30, newRoom));
        tempRooms.get(0).fade = "out";  // Temporary room for fade-out effect
        myRooms.remove(0);
        newRoom = -1;
        roomX = -roomX+(myPlayer.size+wallSize)/scale;  // Set new room to main room
        myRooms.get(0).x = 0;
        roomCol -= 1;  // Move current room left
      } break;
  }  
  
  
  myPlayer.weapon.update();
  if(mouse) {
    myPlayer.weapon.shoot(); 
  }
  
  
  
  // Darkness //
  darkness();
  
  
  // HUD //
  minimap();
  healthBar();
  
  // Weapon Indicator 
  boolean test = false;
  inSize = 75*scale;  // Indicator size
  inOffset = 20*scale;  // Indicator offset 
  for(int i = 0; i < myPlayer.myWeapons.length; i++) {
    WeaponIndicator(myPlayer.myWeapons[i], width-inSize/2-inOffset, inSize/2+inOffset+(inSize+inOffset)*i, inSize, inSize, 2*scale, test);
  }
  
  // Weapon Selector
  slSpeed += 5;
  if(dist(0,slY, 0,slTargetY) < slSpeed) { slY = slTargetY; slSpeed = default_slSpeed; } // Set position to current selected weapon
  if(key1) selectWeapon(0); else if(key2) selectWeapon(1); else if(key3) selectWeapon(2); else if(key4) selectWeapon(3);
  if(!(slY == slTargetY)) slY = slTargetY > slY ? slY+slSpeed : slY-slSpeed;
  
  fill(255);
  noStroke();
  circle(width-inOffset-inSize-10, slY, 10);
} 
