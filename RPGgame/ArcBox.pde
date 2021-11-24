void arcBox(float x, float y, float w, float h, float r, float startAngle, float targetAngle, color base, color overlay) {
  
  PVector origin = new PVector(x,y);
  
  float a1x = 
    startAngle >= -45 && startAngle <= 45 || startAngle >= 270+45 && startAngle <= 360 ?  // Right side of square
      w/2 :          
    startAngle >= 180-45 && startAngle <= 180+45 || startAngle >= -180-45 && startAngle <= -180+45 ?  // Left side of square
      -w/2 :  
    startAngle > 45 && startAngle < 90+45 ?  // Bottom of square
      tan(radians(90-startAngle))*h/2 :
    startAngle > -270-45 && startAngle < -270+45 ?
      tan(radians(-270+startAngle))*h/2 :
    startAngle > 180+45 && startAngle < 270+45 ?  // Top of square
      -tan(radians(270-startAngle))*h/2 :
    startAngle > -90-45 && startAngle < -45 ?
      -tan(radians(90-startAngle))*h/2 :
      0;
  
  float a1y = 
    startAngle >= -45 && startAngle <= 45 ?  // Right side of square
      tan(radians(startAngle))*w/2 :          
    startAngle >= 270+45 && startAngle <= 360 ?
      -tan(radians(360-startAngle))*w/2 :
    startAngle >= 180-45 && startAngle <= 180+45 ?  // Left side of square
      tan(radians(180-startAngle))*w/2 :  
    startAngle >= -180-45 && startAngle <= -180+45 ?
      -tan((180-startAngle))*w/2 :
    startAngle > 45 && startAngle < 90+45 || startAngle > -270-45 && startAngle < -270+45 ?  // Bottom of square
      h/2 :
    startAngle > 180+45 && startAngle < 270+45 || startAngle > -90-45 && startAngle < -45 ?  // Top of square
      -h/2 :
      0;
      
  float a2x = 
    targetAngle >= -45 && targetAngle <= 45 || targetAngle >= 270+45 && targetAngle <= 360 ?  // Right side of square
      w/2 :          
    targetAngle >= 180-45 && targetAngle <= 180+45 || targetAngle >= -180-45 && targetAngle <= -180+45 ?  // Left side of square
      -w/2 :  
    targetAngle > 45 && targetAngle < 90+45 ?  // Bottom of square
      tan(radians(90-targetAngle))*h/2 :
    targetAngle > -270-45 && targetAngle < -270+45 ?
      tan(radians(-270+targetAngle))*h/2 :
    targetAngle > 180+45 && targetAngle < 270+45 ?  // Top of square
      -tan(radians(270-targetAngle))*h/2 :
    targetAngle > -90-45 && targetAngle < -45 ?
      -tan(radians(90-targetAngle))*h/2 :
      0;
  
  float a2y = 
    targetAngle >= -45 && targetAngle <= 45 ?  // Right side of square
      tan(radians(targetAngle))*w/2 :          
    targetAngle >= 270+45 && targetAngle <= 360 ?
      -tan(radians(360-targetAngle))*w/2 :
    targetAngle >= 180-45 && targetAngle <= 180+45 ?  // Left side of square
      tan(radians(180-targetAngle))*w/2 :  
    targetAngle >= -180-45 && targetAngle <= -180+45 ?
      -tan((180-targetAngle))*w/2 :
    targetAngle > 45 && targetAngle < 90+45 || targetAngle > -270-45 && targetAngle < -270+45 ?  // Bottom of square
      h/2 :
    targetAngle > 180+45 && targetAngle < 270+45 || targetAngle > -90-45 && targetAngle < -45 ?  // Top of square
      -h/2 :
      0;
  
  PVector arm1 = new PVector(origin.x+a1x, origin.y+a1y);  // two rotating arms
  PVector arm2 = new PVector(origin.x+a2x, origin.y+a2y);
  PVector c1 = new PVector(origin.x+w/2, origin.y+h/2);  // four corner points
  PVector c2 = new PVector(origin.x-w/2, origin.y+h/2);
  PVector c3 = new PVector(origin.x-w/2, origin.y-h/2);
  PVector c4 = new PVector(origin.x+w/2, origin.y-h/2);
  noFill();
  rectMode(CENTER);
  fill(base);
  rect(origin.x, origin.y, w, h);
  beginShape();
    fill(overlay);
    vertex(origin.x, origin.y);
    vertex(arm1.x, arm1.y);
    if(between(45, startAngle, targetAngle) || between(45, targetAngle, startAngle)) vertex(c1.x, c1.y);
    if(between(135, startAngle, targetAngle) || between(135, targetAngle, startAngle)) vertex(c2.x, c2.y);
    if(between(225, startAngle, targetAngle) || between(225, targetAngle, startAngle)) vertex(c3.x, c3.y);
    if(between(315, startAngle, targetAngle) || between(315, targetAngle, startAngle)) vertex(c4.x, c4.y);
    vertex(arm2.x, arm2.y);
    vertex(origin.x, origin.y);
  endShape();
  
}

boolean between(float num, float low, float high) {
  return num > low && num < high;
}
