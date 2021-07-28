class Rock extends StationaryObject {
  int health;
  
  Rock(PVector pos, PVector dim) {
    super(pos, dim);
    objectType = ROCK_TYPE;
    //dim = new PVector(60, 75);
    health = 10;
  }
  
  void drawMe() {
    pushMatrix();
    fill(89, 60, 31);
    translate(pos.x, pos.y);
    arc(0, 0, dim.x, dim.y, 3*PI/4, 9*PI/4, CHORD);
    
    popMatrix();
  }
  
  void drawMe(Player p) {
    pushMatrix();
    fill(89, 60, 31);
    stroke(0);
    strokeWeight(1);
    translate(-p.pos.x + pos.x, -p.pos.y + pos.y);
    arc(0, 0, dim.x, dim.y, 3*PI/4, 9*PI/4, CHORD);
    
    popMatrix();
  }
  
  void update() {
    super.update(p1);
    if (health < 0) {
      itemDrops.add(new ItemDrop(pos, STONE));
      gw.objects.remove(this);
    }
  }
}
