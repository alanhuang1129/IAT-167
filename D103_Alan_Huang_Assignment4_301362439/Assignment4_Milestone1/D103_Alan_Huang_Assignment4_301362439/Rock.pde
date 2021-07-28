class Rock extends StationaryObject {
  int dim; //Circular
  int health;
  
  Rock(PVector pos) {
    super(pos);
    objectType = ROCK_TYPE;
    dim = 75;
    health = 10;
  }
  
  void drawMe() {
    pushMatrix();
    fill(89, 60, 31);
    translate(pos.x, pos.y);
    circle(0, 0, dim);
    
    popMatrix();
  }
  
  void update() {
    super.update();
    if (health < 0) {
      itemDrops.add(new ItemDrop(pos, STONE));
      rocks.remove(this);
    }
  }
}
