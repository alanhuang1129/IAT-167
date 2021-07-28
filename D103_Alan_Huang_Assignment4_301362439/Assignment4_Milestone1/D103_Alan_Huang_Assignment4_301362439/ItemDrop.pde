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
    return (p.pos.x - p.entityWidth/2 < pos.x + dim &&
            p.pos.x + p.entityWidth/2 > pos.x - dim &&
            p.pos.y - p.entityHeight/2 < pos.y + dim &&
            p.pos.y + p.entityHeight/2 > pos.y - dim);
  }
  
  void update() {
    drawMe();
    if (detectPickup(p1)) {
      //insert add to player inventory code here
      
      itemDrops.remove(this);
    }
  }
  
  void drawMe() {
    fill(120, 20, 120);
    circle(pos.x, pos.y, dim);
  }
}
