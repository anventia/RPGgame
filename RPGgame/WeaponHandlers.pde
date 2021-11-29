void selectWeapon(int index) {
   myPlayer.selectedWeapon = index;  // Basic Weapon
   slTargetY = inSize/2+inOffset+(inSize+inOffset)*myPlayer.selectedWeapon;
}

void WeaponIndicator(Weapon weapon, float x, float y, float w, float h, float r, boolean trigger) {
  noStroke();
  pushMatrix(); translate(x, y); rotate(radians(-90)); arcBox(0,0, w,h, r, 0, map(weapon.timer, 0, weapon.readyTime, 0, 360), 200, 0); popMatrix();
  stroke(255);
  strokeWeight(2);
  noFill();
  rect(x,y, w,h, r);
  PImage icon = gunIcons[weapon.index];
  imageMode(CENTER);
  image(icon, x,y, w,h);
  if(weapon.unlocked != 1) {  // If unlocked, grey out the weapon
    fill(100, 75);
    stroke(100, 75);
    rect(x,y, w,h, r);
  }
}
