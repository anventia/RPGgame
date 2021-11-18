void arcBox(float x, float y, float w, float h, float r, float startAngle, float targetAngle, color base, color overlay) {
  PGraphics box = createGraphics(width,height);
  box.beginDraw();
    box.rectMode(CENTER);
    box.fill(255);
    box.noStroke();
    box.rect(x,y, w,h, r);
  box.endDraw();
  PImage mask = box.get();
  box.beginDraw();
    box.fill(base);
    box.rect(x,y, w,h, r);
    box.fill(overlay);
    box.arc(x,y, w*2,h*2, radians(startAngle), radians(targetAngle));
  box.endDraw();
  
  PImage result = box.get();
  result.mask(mask);
  imageMode(CORNER);
  image(result, 0,0);
  
}
