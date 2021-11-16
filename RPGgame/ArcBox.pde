void arcBox(float x, float y, float w, float h, float r, float startAngle, float targetAngle) {
  PGraphics box = createGraphics(width,height);
  box.beginDraw();
    box.rectMode(CENTER);
    box.fill(200);
    box.noStroke();
    box.rect(x,y, w,h, r);
  box.endDraw();
  PImage mask = box.get();
  box.beginDraw();
    box.fill(0);
    box.arc(x,y, w*2,h*2, radians(startAngle), radians(startAngle+targetAngle));
  box.endDraw();
  
  PImage result = box.get();
  result.mask(mask);
  
  image(result, 0,0);
}
