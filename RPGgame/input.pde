
boolean keyW, keyA, keyS, keyD, keyQ;
boolean key1, key2, key3, key4, key5;

void keyPressed() {
  switch(key) {
    case 'W': case 'w': keyW = true; break;
    case 'A': case 'a': keyA = true; break;
    case 'S': case 's': keyS = true; break;
    case 'D': case 'd': keyD = true; break;
    
    case '1': key1 = true; break;
    case '2': key2 = true; break;
    case '3': key3 = true; break;
    case '4': key4 = true; break;
    case '5': key5 = true; break;
    
    case 'Q': case 'q': keyQ = true; break;
  }
}

void keyReleased() {
  switch(key) {
    case 'W': case 'w': keyW = false; break;
    case 'A': case 'a': keyA = false; break;
    case 'S': case 's': keyS = false; break;
    case 'D': case 'd': keyD = false; break;
    
    case '1': key1 = false; break;
    case '2': key2 = false; break;
    case '3': key3 = false; break;
    case '4': key4 = false; break;
    case '5': key5 = false; break;
    
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
