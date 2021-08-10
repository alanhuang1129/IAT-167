class StationaryObject {
  PVector pos, dim;
  int objectType;
  
  final int ROCK_TYPE = 1;
  
  StationaryObject(PVector pos, PVector dim){
    this.pos = pos;
    this.dim = dim;
  }
  
  void handleCollision(Entity other) { //NEEDS FIXING
    //circle(-other.pos.x + pos.x, -other.pos.y + pos.y, 100);
    boolean left = false;
    boolean right = false;
    boolean bot = false;
    boolean top = false;
    if (detectCollision(other) && -other.pos.y + pos.y < other.pos.y) {
      //Collision on the bottom side
      //println("bot");
      bot = true;
      //other.pos.y = other.pos.y + 10;
    }
    else bot = false;
    if (detectCollision(other) && -other.pos.y + pos.y > other.pos.y) {
      //Collision on the top side
      //println("top");
      top = true;
      //other.pos.y = other.pos.y - 10;
    }
    else top = false;
    if (detectCollision(other) && -other.pos.x + pos.x > other.pos.x && other.pos.y < pos.y + dim.y/2 && other.pos.y > dim.y/2) {
      //Collision on left side
      //println("left");
      left = true;
      //other.pos.x = other.pos.x - 10;
    }
    else left = false;
    if (detectCollision(other) && -other.pos.x + pos.x < other.pos.x && other.pos.y < pos.y + dim.y/2 && other.pos.y > dim.y/2) {
      //Collision on the right side
      //println("right");
      right = true;
      //other.pos.x = other.pos.x + 10;
    }
    else right = false;
    
    if (top == true) {
      //left = false;
      //right = false;
    }
    
    if (bot == true) {
      //left = false;
      //right = false;
    }
    if (left == true) other.pos.x = other.pos.x - 10;
    if (right == true) other.pos.x = other.pos.x + 10;
    if (top == true) other.pos.y = other.pos.y - 10;
    if (bot == true) other.pos.y = other.pos.y + 10;
  }
  
  boolean detectCollision(Entity other) {
    return (-other.pos.x + pos.x - dim.x/2 < other.pos.x + other.entityWidth/2 &&
            -other.pos.x + pos.x + dim.x/2 > other.pos.x - other.entityWidth/2 &&
            -other.pos.y + pos.y + dim.y/2 > other.pos.y - other.entityHeight/2 &&
            -other.pos.y + pos.y - dim.y/2 < other.pos.y + other.entityHeight/2);
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
    handleCollision(p1);
  }
}
