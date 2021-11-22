void selectWeapon(int index) {
   myPlayer.selectedWeapon = index;  // Basic Weapon
   slTargetY = inSize/2+inOffset+(inSize+inOffset)*myPlayer.selectedWeapon;
}

void WeaponIndicator(Weapon weapon, float x, float y, float w, float h, float r, boolean trigger) {
  //arcBox(x,y, w,h, r, -90+map(weapon.timer, 0, weapon.readyTime, 0, 360), -90+360, 0, 200);
  stroke(255);
  strokeWeight(2);
  noFill();
  rect(x,y, w,h, r);
  PImage icon = gunIcons[weapon.index];
  imageMode(CENTER);
  image(icon, x,y, w,h);
}
