// Window Scaling // Makes UI scale to window size // 960x540 default
float scaleX, scaleY, scale;
void scaleWindow() {
  scaleX = 1.0/960*width;
  scaleY = 1.0/540*height;
  scale = scaleX < scaleY ? scaleX : scaleY;  // Sets scale to the smaller of scaleX or scaleY
}
