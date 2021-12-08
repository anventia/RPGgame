class Message extends gameObject {
  // Instance Variables //
  String text;
  color clr;
  String type;
  
  // Constructor //
  Message(String type, String text, float x, float y, float size, color clr) {
    this.type = type;
    this.text = text;
    location = new PVector(x,y);
    velocity = new PVector(random(-1,1),-3);
    this.size = size;
    this.clr = clr;
    lives = 20;
    mapCol = myPlayer.mapCol;
    mapRow = myPlayer.mapRow;
  }
  
  
  // Act //
  void act() {
    super.act();
    super.offset();
    lives -= 1;
  }
  
  
  // Show //
  void show() {
    fill(clr);
    textSize(size);
    textAlign(LEFT);
    text(text, location.x+offsetX, location.y+offsetY);
    PImage messageIcon = new PImage();
    switch(type) {
      case "DAMAGE": messageIcon = otherIcons[0]; break;
      case "HEALTH": messageIcon = otherIcons[1]; break;
    }
    image(messageIcon, location.x+offsetX-size/2, location.y+offsetY, size, size);
  }
}
