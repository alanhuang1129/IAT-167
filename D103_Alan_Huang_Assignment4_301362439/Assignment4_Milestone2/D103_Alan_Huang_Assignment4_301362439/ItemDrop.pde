class ItemDrop {
  PVector pos;
  int itemType;
  int dim; //It will be circular
  
  ItemDrop(PVector pos, int itemType) {
    this.pos = pos;
    this.itemType = itemType;
    dim = 25;
  }
  
  boolean detectPickup(Player p) { //Using box collision detection
    return (p.pos.x - p.entityWidth/2 < -p.pos.x + pos.x + dim &&
            p.pos.x + p.entityWidth/2 > -p.pos.x + pos.x - dim &&
            p.pos.y - p.entityHeight/2 < -p.pos.y + pos.y + dim &&
            p.pos.y + p.entityHeight/2 > -p.pos.y + pos.y - dim);
  }
  
  void update() {
    drawMe(p1);
    if (detectPickup(p1)) {
      //insert add to player inventory code here
      
      itemDrops.remove(this);
    }
  }
  
  void drawMe() {
    fill(120, 20, 120);
    circle(pos.x, pos.y, dim);
  }
  
  void drawMe(Player p) {
    fill(120, 20, 120);
    pushMatrix();
    translate(-p.pos.x + pos.x, -p.pos.y + pos.y);
    circle(0, 0, dim);
    popMatrix();
  }
}
