void healthBar() {  // Player health bar 
  push();
    colorMode(HSB, 360, 100,100);
    color healthbarColor =  color(myPlayer.lives, 52, 98);
    progressBar(0, map(myPlayer.lives, 0, 100, 0, 1), width/2, height-25*scale, width/2, 20, 0, 5, healthbarColor, 100, 50);
  pop();
}
