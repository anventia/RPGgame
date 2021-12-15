void debugConsole() {
  textFont(consolas);
  textAlign(LEFT);
  textSize(15);
  text("< Debug info >"+
       "\ngameObjects: "+myObjects.size()+
       "\nFramerate: "+round(frameRate)+
       "\nmx: "+mouseX+
       "\nmy: "+mouseY+
       "\n"+tempRoom+" 1"+
       "\n"+tempRoom2+" 2"+
       "\n"+myRooms.size()
       , 20*scale, 240*scale);
}
