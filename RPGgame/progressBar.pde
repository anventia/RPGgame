void progressBar(float ang, float percentage, float x, float y, float w, float h, float r, float border, color fill, color empty, color borderFill) {
  PGraphics bar = createGraphics(width,height);
  PGraphics bar2 = createGraphics(width,height);
    bar.beginDraw();  // Mask
      bar.rectMode(CENTER);
      bar.fill(empty);
      bar.noStroke();
      bar.rect(x, y, w, h, r);
      bar.fill(fill);
      bar.rect(x-w+w*percentage, y, w, h, r);
    bar.endDraw();
    PImage result = bar.get();
    bar2.beginDraw();
      bar2.fill(255);
      bar2.noStroke();
      bar2.rectMode(CENTER);
      bar2.rect(x, y, w, h, r);
    bar2.endDraw();
    PImage container = bar2.get();
  result.mask(container);
 
  pushMatrix();
    rotate(radians(ang));
    translate(x, y);
    rectMode(CENTER);
    noStroke();
    fill(borderFill);
    rect(0, 0, w+border*2, h+border*2, r+border);
  popMatrix();
  
  image(result, 0,0);

}
