class Chest extends StationaryObject {
  int chestType;
  final int IRON_CHEST_TYPE = 1;
  final int GOLD_CHEST_TYPE = 2;
  final color IRON_COLOR = color(220);
  final color GOLD_COLOR = color(255, 255, 0);

  
  Chest(PVector pos, int chestType) {
    super(pos, new PVector(100, 60));
    this.chestType = chestType;
  }
  
  void drawMe(Player p) {
    pushMatrix();
    translate(-p.pos.x + pos.x, -p.pos.y + pos.y);
    if (chestType == IRON_CHEST_TYPE) stroke(IRON_COLOR);
    if (chestType == GOLD_CHEST_TYPE) stroke(GOLD_COLOR);
    strokeWeight(5);
    fill(160, 82, 45);
    rect(-dim.x/2, -dim.y/2, dim.x, dim.y);
    line(-50, -5, 50, -5);
    rect(-10, -10, 20, 15);
    noStroke();
    
    popMatrix();
  }
  
  
  
  void update() {
    drawMe(p1);
    if ((chestType == IRON_CHEST_TYPE && craftMenu.getAmount(IRON_KEY) < 1) || (chestType == GOLD_CHEST_TYPE && craftMenu.getAmount(GOLD_KEY) < 1)) handleCollision(p1); //Handle player collision if they do not have key
    if (super.detectCollision(p1) && craftMenu.getAmount(IRON_KEY) >= 1 && chestType == IRON_CHEST_TYPE) {
      craftMenu.consumeAmount(IRON_KEY, 1);
      itemDrops.add(new ItemDrop(pos, IRON_CHEST));
      gw.objects.remove(this);
    }
    if (super.detectCollision(p1) && craftMenu.getAmount(GOLD_KEY) >= 1 && chestType == GOLD_CHEST_TYPE) {
      craftMenu.consumeAmount(GOLD_KEY, 1);
      itemDrops.add(new ItemDrop(pos, GOLD_CHEST));
      gw.objects.remove(this);
    }
  }
}
