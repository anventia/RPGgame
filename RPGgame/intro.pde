void intro() {
  background(200);
  
  fill(190);
  stroke(190);
  strokeWeight(10*scale);
  if(button("rect", width/2, height/2, width+10, 115, 0, "stroke", 190, 0, 10*scale, 3)) { mode = GAME; }
  
  fill(0);
  textFont(consolas);
  textSize(75);
  textAlign(CENTER);
  String introText = buttonHover[3] ? "play" : "intro";  // Set to "play" when hovering over button, else, set to "intro"
  String introSpacing = buttonHover[3] ? "    " : "     ";  // Set number of spaces (for different color text)
  
  text("rpg.game("+introSpacing+");", width/2, height/2+20*scale);
  fill(buttonHover[3] ? #5DED85 : #5D8CED);
  text("         "+introText+"  ", width/2, height/2+20*scale);
  
  
}
