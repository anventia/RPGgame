void game() {
  background(0);

  gameScale = default_roomScale*scale;
  doorSize = default_doorSize*gameScale;
  
  
  // Rooms //
  for(Room obj : myRooms) {  // Main rooms
    obj.show();
    obj.fade();
    if(!paused) obj.act();
  }
    
  for(int i = 0; i < tempRooms.size(); i++) {  // Temporary rooms
    Room obj = tempRooms.get(i);
    obj.show();
    if(!paused) obj.act();
  }
  
  
  // Doors //
  upDoor = downDoor = leftDoor = rightDoor = false;
  if(minimap[roomRow-2] [roomCol-1] != 0) upDoor = true;
  if(minimap[roomRow]   [roomCol-1] != 0) downDoor = true;
  if(minimap[roomRow-1] [roomCol-2] != 0) leftDoor = true;
  if(minimap[roomRow-1] [roomCol]   != 0) rightDoor = true;
  
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
 
  /* // Weird rotate: rotate((atan((height/2-mouseY)-(width/2-mouseX))));
  pushMatrix();  // Debug line 
    translate(width/2, height/2);
    rotate((atan2((mouseY-height/2), (mouseX-width/2))));
    noFill();
    strokeWeight(5);
    stroke(255,0,255);
    line(0,0, 100,0);
  popMatrix();
  */
  
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
  if(!paused) {
    if(keyW && upMove)    { roomY += myPlayer.speed*speedPercentage; }
    if(keyA && leftMove)  { roomX += myPlayer.speed*speedPercentage; }
    if(keyS && downMove)  { roomY -= myPlayer.speed*speedPercentage; }
    if(keyD && rightMove) { roomX -= myPlayer.speed*speedPercentage; }
  }
  
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
    tempRoom2 = new PVector(myPlayer.mapRow+1, myPlayer.mapCol);
  }
  
  if(leftWall && newRoom == -1 && leftDoor) {  // Left 
    newRoom = 3;
    myRooms.add(new Room(-(roomSize*gameScale+wallSize), 0, newRoom));
  }
  
  
  // Remove unneeded rooms  / Show temporary rooms // 
  switch(newRoom) {
    case 0:  // Top
      if(roomY*scale < (roomSize*gameScale)/2-myPlayer.rad) { myRooms.remove(1); newRoom = -1; break; }  // Remove new room if player doesn't enter it
      else if(roomY*scale > (myPlayer.rad+wallSize+roomSize*gameScale/2)) {  // Remove old room on the bottom [ENTER NEW ROOM: TOP]
        tempRooms.add(new Room(myRooms.get(0).x,myRooms.get(0).y+roomSize*gameScale+wallSize, 30, newRoom));
        tempRoom = new PVector(myPlayer.mapRow, myPlayer.mapCol);
        offset.offsetX = offset.offsetY = 0;
        tempRooms.get(0).fade = "out";  // Temporary room for fade-out effect
        myRooms.remove(0);
        newRoom = -1;
        roomY = -roomY+(myPlayer.size+wallSize)/scale;  // Set new room to main room
        myRooms.get(0).y = 0;
        roomRow -= 1;  // Move current room up
      } break;
      
    case 1:  // Right
      if(roomX*scale > -((roomSize*gameScale)/2-myPlayer.rad)) { myRooms.remove(1); newRoom = -1; break; }  // Remove new room if player doesn't enter it
      else if(roomX*scale < -(myPlayer.rad+wallSize+roomSize*gameScale/2)) {  // Remove old room on the left [ENTER NEW ROOM: RIGHT]
        tempRooms.add(new Room(myRooms.get(0).x-roomSize*gameScale-wallSize,myRooms.get(0).y, 30, newRoom));
        tempRoom = new PVector(myPlayer.mapRow, myPlayer.mapCol);
        offset.offsetX = offset.offsetY = 0;
        tempRooms.get(0).fade = "out";  // Temporary room for fade-out effect
        myRooms.remove(0);
        newRoom = -1;
        roomX = -roomX-(myPlayer.size+wallSize)/scale;  // Set new room to main room
        myRooms.get(0).x = 0;  
        roomCol += 1;  // Move current room right
      } break;
      
    case 2:  // Bottom
      if(roomY*scale > -1*((roomSize*gameScale)/2-myPlayer.rad)) { myRooms.remove(1); newRoom = -1; break; }  // Remove new room if player doesn't enter it
      else if(roomY*scale < -(myPlayer.rad+wallSize+roomSize*gameScale/2)) {  // Remove old room on the top [ENTER NEW ROOM: BOTTOM]
        tempRooms.add(new Room(myRooms.get(0).x,myRooms.get(0).y-roomSize*gameScale-wallSize, 30, newRoom));
        tempRoom = new PVector(myPlayer.mapRow, myPlayer.mapCol);
        offset.offsetX = offset.offsetY = 0;
        tempRooms.get(0).fade = "out";  // Temporary room for fade-out effect
        myRooms.remove(0);
        newRoom = -1;
        roomY = -roomY-(myPlayer.size+wallSize)/scale;  // Set new room to main room
        myRooms.get(0).y = 0;
        roomRow += 1;  // Move current room down
      } break;
      
    case 3:  // Left
      if(roomX*scale < (roomSize*gameScale)/2-myPlayer.rad) { myRooms.remove(1); newRoom = -1; break; }  // Remove new room if player doesn't enter it
      else if(roomX*scale > (myPlayer.rad+wallSize+roomSize*gameScale/2)) {  // Remove old room on the right [ENTER NEW ROOM: LEFT]
        tempRooms.add(new Room(myRooms.get(0).x+roomSize*gameScale+wallSize,myRooms.get(0).y, 30, newRoom));
        tempRoom = new PVector(myPlayer.mapRow, myPlayer.mapCol);
        offset.offsetX = offset.offsetY = 0;
        tempRooms.get(0).fade = "out";  // Temporary room for fade-out effect
        myRooms.remove(0);
        newRoom = -1;
        roomX = -roomX+(myPlayer.size+wallSize)/scale;  // Set new room to main room
        myRooms.get(0).x = 0;
        roomCol -= 1;  // Move current room left
      } break;
  }  
  
  
  // Render sword for <weapon index 4> //
  for(int i = 0; i < myWeapons.length; i++) {
    if(i == 4) myWeapons[i].sword();
  }
  
  
  // GameObjects //
  for(int i = 0; i < myObjects.size(); i++) {  // Main loop
    gameObject obj = myObjects.get(i);
    if(!obj.roomWith(myPlayer) && !(obj instanceof Player || obj instanceof Laser || obj instanceof Item) || obj instanceof Laser && myWeapons[myPlayer.selectedWeapon].index == 4) continue;
    if(!paused) obj.act();
    if(!obj.roomWith(myPlayer)) continue;
    obj.show();
    if(obj.lives <= 0) myObjects.remove(i);
  }
     
    
  // Show enemies when peeking into another room (Temporary Rooms) //
  offset.offset();
  for(gameObject obj : myObjects) {  
    boolean InTempRoom = (obj.mapRow == int(tempRoom.x) && obj.mapCol == int(tempRoom.y)) || (obj.mapRow == int(tempRoom2.x) && obj.mapCol == int(tempRoom2.y)) ;
        
    if(InTempRoom && tempRooms.size() > 0 && !tempRooms.get(0).fade.equals("off")) { 
      pushMatrix(); 
      
        translate(offset.offsetX, offset.offsetY); 
        if(!(obj instanceof Item)) { obj.show(); }  // Items don't offset properly (FIX!)
      popMatrix(); 
    }
  }
  
  
  for(int i = 0; i < tempRooms.size(); i++) {  // Temoporary rooms
    Room obj = tempRooms.get(i);
    obj.fade();
    if(obj.lives == 0) tempRooms.remove(i);
  }
  
  
  // Darkness //
  darkness();
  
  
  // HUD //
  minimap();
  healthBar();
  if(debugconsole == 1) debugConsole();
   
  
  // Weapon Indicator 
  for(int i = 0; i < myWeapons.length; i++) {
    WeaponIndicator(myWeapons[i], width-inSize/2-inOffset, inSize/2+inOffset+(inSize+inOffset)*i, inSize, inSize, 2*scale);
    if(!paused) myWeapons[i].update();
  }
  
  
  // Player shoot //
  if(mouse && !paused) {
    myPlayer.weapon.shoot(); 
  }
   
  
  // Weapon Selector //
  if(!paused) {
    slSpeed += 5;
    if(dist(0,slY, 0,slTargetY) < slSpeed) { slY = slTargetY; slSpeed = default_slSpeed; } // Set position to current selected weapon
    if(key1 && myWeapons[0].unlocked == 1) selectWeapon(0); 
    if(key2 && myWeapons[1].unlocked == 1) selectWeapon(1); 
    if(key3 && myWeapons[2].unlocked == 1) selectWeapon(2); 
    if(key4 && myWeapons[3].unlocked == 1) selectWeapon(3);
    if(key5 && myWeapons[4].unlocked == 1) selectWeapon(4);
    if(!(slY == slTargetY)) slY = slTargetY > slY ? slY+slSpeed : slY-slSpeed;  // Move selector dot
  }
  fill(255);  // Draw selector dot
  noStroke();
  circle(width-inOffset-inSize-10, slY, 10);
  
  
  // Pause //
  if(!paused && esc) { esc = false; paused = true; }
  if(paused) {
    fill(0,200);
    noStroke();
    rectMode(CORNER);
    rect(0,0, width,height);  // ADD ANIMATION HERE!!
    pauseMenu = true;  // Finish animation, load menu
    if(pauseMenu) {  // menu
      noFill(); 
      stroke(200);
      strokeWeight(10*scale);
      imageMode(CENTER);
      if(button("circle", width*0.2,height/2, 150*scale,150*scale, 0, "stroke", 255, 20*scale, 10*scale, 0) && money >= 70) { damagePercentage += 0.05; money -= 70; }  // Left
      image(otherIcons[0], width*0.2, height/2, 150*scale, 150*scale);
      stroke(200);
      if(button("circle", width/2,height/2, 150*scale,150*scale, 0, "stroke", 255, 20*scale, 10*scale, 1) && money >= 50) { maxHealth += 10; money -= 50; }  // Middle
      image(otherIcons[1], width/2, height/2, 150*scale, 150*scale);
      stroke(200);
      if(button("circle", width*0.8,height/2, 150*scale,150*scale, 0, "stroke", 255, 20*scale, 10*scale, 2) && money >= 30) { speedPercentage += 0.05; money -= 30; }  // Right
      image(otherIcons[2], width*0.8, height/2, 150*scale, 150*scale);
      int hoveredButtonIndex = -1; for(int i = 0; i < pauseMenuHover.length; i++) { if(pauseMenuHover[i]) hoveredButtonIndex = i; }  // Get the index of the button currently being hovered
      fill(255);
      textFont(consolas);
      textSize(45*scale);
      textAlign(CENTER);
      switch(hoveredButtonIndex) {  // Show text on hovered button
        case 0:  // Left button
          text("DAMAGE", width*0.2, height/2-150*scale);
          textSize(30*scale);
          text("$70", width*0.2, height/2-115*scale);
          textSize(45*scale);
          text("+5%", width*0.2, height/2+150*scale);
          textSize(30*scale);
          text(round(damagePercentage*100)+"% -> "+round((damagePercentage+0.05)*100)+"%", width*0.2, height/2+185*scale);
          break;
        case 1:  // Middle button
          text("MAX HP", width/2, height/2-150*scale);
          textSize(30*scale);
          text("$50", width/2, height/2-115*scale);
          textSize(45*scale);
          text("+10", width/2, height/2+150*scale);
          textSize(30*scale);
          text(maxHealth+" -> "+(maxHealth+10), width/2, height/2+185*scale);
          break;
        case 2:  // Right button
          text("SPEED", width*0.8, height/2-150*scale);
          textSize(30*scale);
          text("$30", width*0.8, height/2-115*scale);
          textSize(45*scale);
          text("+5%", width*0.8, height/2+150*scale);
          textSize(30*scale);
          text(round(speedPercentage*100)+"% -> "+round((speedPercentage+0.05)*100)+"%", width*0.8, height/2+185*scale);
          break;
      }
      
    }
    if(paused && esc) { esc = pauseMenu = paused = false; }
  }
  
  fill(255);
  textFont(consolas);
  textSize(15);
  textAlign(LEFT);
  text("$ "+money, 20*scale, height-20*scale);  // Show money
  
} 

class Offset extends gameObject {  // Temporary object to store values for temporary enemies
 Offset() {
 }
}
