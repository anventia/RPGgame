void healthBar() {  // Player health bar 
  push();
    colorMode(HSB, 360, 100,100);
    color healthbarColor =  color(myPlayer.lives, 52, 98); 
  pop();
  rectMode(CENTER);
  fill(0);
  stroke(100);
  strokeWeight(2);
  rect(width/2, height-25*scale, width/2+5*scale, 25*scale);  // Black border
  fill(healthbarColor);
  noStroke();
  rectMode(CORNER);
  rect(width/4, height-25*scale-10*scale, width/2*map(myPlayer.lives, 0, maxHealth, 0, 1), 20*scale);  // Bar
  //progressBar(0, map(myPlayer.lives, 0, 100, 0, 1), width/2, height-25*scale, width/2, 20, 0, 5, healthbarColor, 100, 50);
  
  fill(0);
  textFont(consolas);
  textSize(15*scale);
  textAlign(CENTER);
  
  text(myPlayer.lives+" / "+maxHealth, width/2-1*scale, height-19*scale);
  fill(255);
  text(myPlayer.lives+" / "+maxHealth, width/2, height-20*scale);
}
