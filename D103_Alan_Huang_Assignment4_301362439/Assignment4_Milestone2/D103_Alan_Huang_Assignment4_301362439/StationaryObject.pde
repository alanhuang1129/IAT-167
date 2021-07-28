class StationaryObject {
  PVector pos, dim;
  int objectType;
  
  final int ROCK_TYPE = 1;
  
  StationaryObject(PVector pos, PVector dim){
    this.pos = pos;
    this.dim = dim;
  }
  
  void handleCollision(Entity other) { //NEEDS FIXING
    if (detectCollision(other) && pos.x - dim.x/2 < other.pos.x + other.entityWidth/2) {
      //Collision on left side
      println("left");
      other.pos.x = pos.x - dim.x/2 - other.entityWidth/2;
    }
    if (detectCollision(other) && pos.x + dim.x/2 > other.pos.x - other.entityWidth/2) {
      //Collision on the right side
      println("right");
      other.pos.x = pos.x + dim.x/2 + other.entityWidth/2;
    }
    if (detectCollision(other) && pos.y + dim.y/2 > other.pos.y - other.entityHeight/2) {
      //Collision on the bottom side
      println("bot");
      other.pos.y = pos.y + dim.x/2 + other.entityHeight/2;
    }
    if (detectCollision(other) && pos.y - dim.y/2 < other.pos.y + other.entityHeight/2) {
      //Collision on the top side
      println("top");
      other.pos.y = pos.y - dim.x/2 - other.entityHeight/2;
    }
  }
  
  boolean detectCollision(Entity other) {
    return (pos.x - dim.x/2 < other.pos.x + other.entityWidth/2 &&
            pos.x + dim.x/2 > other.pos.x - other.entityWidth/2 &&
            pos.y + dim.y/2 > other.pos.y - other.entityHeight/2 &&
            pos.y - dim.y/2 < other.pos.y + other.entityHeight/2);
  }
  
  void drawMe() {
    //placeholder
  }
  void drawMe(Player p) {
    //placeholder
  }
  
  void update() {
    drawMe();
  }
  void update(Player p) {
    drawMe(p);
    for (int i = 0; i < enemies.size(); i++) {
      Enemy currEnemy = enemies.get(i);
      handleCollision(currEnemy);
    }
    //handleCollision(p1);
  }
}
