void arcBox(float x, float y, float w, float h, float r, float startAngle, float targetAngle, color base, color overlay) {
  /*
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
  */
  
  PVector origin = new PVector(x,y);
  
  float a1x = 
    startAngle >= -45 && startAngle <= 45 ?  // Right side of square
      w/2 :  
    startAngle >= 180-45 && startAngle <= 180+45 ?  // Left side of square
      -w/2 :  
    startAngle > 45 && startAngle < 90+45 ?  // Bottom of square
      tan(90-startAngle)*h/2 :
    startAngle > 180+45 && startAngle < 270+45 ?  // Top of square
      -tan(270-startAngle)*h/2 :
      0;
  
  float a1y = 
    startAngle >= -45 && startAngle <= 45 ?  // Right side of square                          /// ADD another right side of square for angles from 315-360
      tan(startAngle)*w/2* startAngle  :
    startAngle >= 180-45 && startAngle <= 180+45 ?  // Left side of square
      -w/2 :  
    startAngle > 45 && startAngle < 90+45 ?  // Bottom of square
      h/2 :
    startAngle > 180+45 && startAngle < 270+45 ?  // Top of square
      -h/2 :
      0;
  
  //PVector arm1 = new PVector(a1x,a1y);
  
  //line(origin.x,origin.y, 
}
