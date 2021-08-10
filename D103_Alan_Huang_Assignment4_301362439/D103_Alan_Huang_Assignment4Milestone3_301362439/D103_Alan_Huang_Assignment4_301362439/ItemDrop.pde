class ItemDrop {
  PVector pos;
  int itemType;
  int dim; //It will be circular
  color dropColor;
  final color ENEMY_SOUL_COLOR = color(120, 20, 120);
  final color STONE_COLOR = color(89, 60, 31);
  final color COAL_COLOR = color(0);
  final color IRON_COLOR = color(120);
  final color GOLD_COLOR = color(255, 255, 0);
  
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
      p1.materials.add(new Material(itemType));
      itemDrops.remove(this);
    }
  }
  
  void drawMe() {
    fill(120, 20, 120);
    circle(pos.x, pos.y, dim);
  }
  
  void drawMe(Player p) {
    switch(itemType) {
      case ENEMY_SOUL_DROP:
        dropColor = ENEMY_SOUL_COLOR;
        break;
      case STONE:
        dropColor = STONE_COLOR;
        break;
      case COAL:
        dropColor = COAL_COLOR;
        break;
      case IRON:
        dropColor = IRON_COLOR;
        break;
      case GOLD:
        dropColor = GOLD_COLOR;
        break;
    }
    fill(dropColor);
    pushMatrix();
    translate(-p.pos.x + pos.x, -p.pos.y + pos.y);
    circle(0, 0, dim);
    popMatrix();
  }
}
