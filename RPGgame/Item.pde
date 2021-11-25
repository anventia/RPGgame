class Item extends gameObject {
  // Instance Variables //
  
   
  // Constructor //
  Item(String type, float x, float y, int mapCol, int mapRow) {
    location = new PVector(0,0);
    this.default_location = new PVector(x,y);
    this.type = type;
    this.mapCol = mapCol;
    this.mapRow = mapRow;
    default_size = 100;
    lives = 1;
  }
  
  
  // Act //
  void act() {
    location.x = default_location.x+roomX*scale;
    location.y = default_location.y+roomY*scale;
    size = default_size*gameScale;
    rad = size/2;
    
  }
  
  
  // Show //
  void show() {
    println(location);
    fill(type == "WEAPON" ? iWeapon : iHealth);
    stroke(type == "WEAPON" ? iWeapon_s : iHealth_s);
    circle(location.x, location.y, size);
  }
}
