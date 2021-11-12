class Follower extends Enemy {
  Follower() {
    super(
      new PVector(300*gameScale, -300*gameScale),  // Location
      75,  // Size
      100,  // Lives
      3,  // Map Column
      3,  // Map Row
      #65E882,  // Color
      #0BE037  // Stroke Color
    );
  }
  
  void act() {
    super.act();
    
  }
}
