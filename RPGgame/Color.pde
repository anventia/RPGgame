class Color {
  // Instance Variables //
  int H;
  int S;
  int B;
  
  // Constructor //
  Color(int H, int S, int B) {
    this.H = H;
    this.S = S;
    this.B = B;
  }
  
  // Color //
  color v() {  // color 
    colorMode(HSB);
    return color(H,S,B); 
  }
  
  color a(int v) {  // adjust color brightness
   return color(H,S,B+v, HSB);
  }
}
