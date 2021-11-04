void door() {
    noStroke();
    fill(door);
    rectMode(CENTER);
    rect(0,-(roomSize*gameScale/2+wallSize/2), doorSize, wallSize-1); 
}
