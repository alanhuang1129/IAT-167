class Ore extends Rock {
  int oreType;
  
  Ore(PVector pos, PVector dim, int oreType) {
    super(pos, dim);
    this.oreType = oreType;
    //I didn't want to import a math library to do exponents
    health = 1;
    for (int i = 0; i < oreType; i++) {
      health *= 5;
    }
  }
  
  void drawMe() {
    super.drawMe();
  }
  
  void drawMe(Player p) {
    super.drawMe(p);
    pushMatrix();
    translate(-p.pos.x + pos.x, -p.pos.y + pos.y);
    switch(oreType) { //color selection of ore
      case COAL:
        fill(0);
        break;
      case IRON:
        fill(120);
        break;
      case GOLD:
        fill(255, 255, 0);
        break;
    }
    circle(-25, -25, 20);
    circle(20, 10, 20);
    circle(0, -15, 20);
    circle(-20, 10, 20);
    
    
    
    popMatrix();
  }
  
  void update() {
    super.update();
    if (health < 0) {
      itemDrops.add(new ItemDrop(pos, oreType));
      gw.objects.remove(this);
    }
  }
}
