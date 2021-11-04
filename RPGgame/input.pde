

boolean keyW, keyA, keyS, keyD, keyQ;

void keyPressed() {
  switch(key) {
    case 'W': case 'w': keyW = true; break;
    case 'A': case 'a': keyA = true; break;
    case 'S': case 's': keyS = true; break;
    case 'D': case 'd': keyD = true; break;
    case 'Q': case 'q': keyQ = true; break;
  }
}


void keyReleased() {
  switch(key) {
    case 'W': case 'w': keyW = false; break;
    case 'A': case 'a': keyA = false; break;
    case 'S': case 's': keyS = false; break;
    case 'D': case 'd': keyD = false; break;
    case 'Q': case 'q': keyQ = false; break;
  }
}

boolean mouse;

void mousePressed() {
  mouse = true;
}

void mouseReleased() {
  mouse = false; 
}
