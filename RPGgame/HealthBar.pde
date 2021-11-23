void healthBar() {  // Player health bar 
  push();
    colorMode(HSB, 360, 100,100);
    color healthbarColor =  color(myPlayer.lives, 52, 98);
    fill(0);
    stroke(0);
    strokeWeight(10);
    rectMode(CENTER);
    rect(width/2, height-25*scale, width/2, 20*scale);
    fill(healthbarColor);
    noStroke();
    rectMode(CORNER);
    rect(width/4, height-25*scale-10*scale, width/2*map(myPlayer.lives, 0, 100, 0, 1), 20*scale);
    //progressBar(0, map(myPlayer.lives, 0, 100, 0, 1), width/2, height-25*scale, width/2, 20, 0, 5, healthbarColor, 100, 50);
  pop();
}
