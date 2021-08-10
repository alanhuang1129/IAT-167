class Enemy extends Entity {
  boolean alive = true;
  boolean drop = false;
  
  Enemy(PVector pos, PVector vel) {
    super(pos, vel);
    health = 15;
    entityWidth = 50;
    entityHeight = 100;
  }
  
  void drawMe() {
    //Character for now (need to get character model)
    fill(0, 255, 0);
    rect(pos.x - entityWidth/2, pos.y - entityHeight/2, entityWidth, entityHeight);
  }
  
  void drawMe(Player p) {
    //Character for now (need to get character model)
    fill(0, 255, 0);
    rect(-p.pos.x + pos.x - entityWidth/2, -p.pos.y + pos.y - entityHeight/2, entityWidth, entityHeight);
  }
  
  void update() {
    super.update();
    drawMe(p1);
    //println(health);
    if (health <= 0) {
      itemDrops.add(new ItemDrop(pos, ENEMY_SOUL_DROP)); 
      enemies.remove(this);
    }
  }
  
}
