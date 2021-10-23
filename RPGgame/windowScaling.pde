// Window Scaling // Makes UI scale to window size // 960x540 default
float scaleX, scaleY, scale, scaleSquare, square;
void scaleWindow() {
  scaleX = 1.0/960*width;
  scaleY = 1.0/540*height;
  if(scaleX < scaleY) scale = scaleX;
  else scale = scaleY;
  
  square = 540*scale;
  
  scaleSquare = 1.0/(540)*square;
}
