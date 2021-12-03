void selectWeapon(int index) {
   myPlayer.selectedWeapon = index;  // Basic Weapon
   slTargetY = inSize/2+inOffset+(inSize+inOffset)*myPlayer.selectedWeapon;
}

void WeaponIndicator(Weapon weapon, float x, float y, float w, float h, float r) {
  noStroke();
  pushMatrix(); translate(x, y); rotate(radians(-90)); arcBox(0,0, w,h, r, 0, map(weapon.timer, 0, weapon.readyTime, 0, 360), 200, 0); popMatrix();
  stroke(255);
  strokeWeight(2);
  noFill();
  rect(x,y, w,h, r);
  PImage icon = gunIcons[weapon.index];  // Get gun icon with index
  imageMode(CENTER);
  image(icon, x,y, w,h);
  fill(255);
  textFont(consolas);
  textSize(30*gameScale);
  textAlign(CENTER);
  text(weapon.index+1, x-w/2+20*gameScale, y+h/2-14*gameScale);  // Index number
  if(weapon.unlocked != 1) {  // If unlocked, grey out the weapon
    fill(0, 100);
    stroke(0, 100);
    rect(x,y, w,h, r);
  }
}
