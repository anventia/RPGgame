void debugConsole() {
  textFont(consolas);
  textAlign(LEFT);
  textSize(15);
  text("[ Debug info ]"+
       "\ngameObjects: "+myObjects.size()+
       "\nFramerate: "+round(frameRate)+
       "\nmx: "+mouseX+
       "\nmy: "+mouseY
       , 20*scale, 240*scale);
}
