class Entity {
  PVector pos, vel;
  int health;
  float entityWidth;
  float entityHeight;
  
  Entity(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    health = 10;
  }
  
  //Add detect stationaryObject() method soon
  
  void detectWalls() {
    //Left wall
    if (pos.x < entityWidth/2) {
      pos.x = entityWidth/2;
    }
    //Right wall
    if (pos.x > width - entityWidth/2) {
      pos.x = width - entityWidth/2;
    }
    //Top wall
    if (pos.y < entityHeight/2) {
      pos.y = entityHeight/2;
    }
    //Bottom wall
    if (pos.y > height - entityHeight/2) {
      pos.y = height - entityHeight/2;
    }
  }
  
  void moveCharacter() {
    pos.add(vel);
  }
  
  void accelerate(PVector a){
    vel.add(a);
  }
  
  void update() {
    detectWalls();
    moveCharacter();
    
  }
  
  void drawMe() {
    //placeholder
  }
  
  boolean hitCharacter(Entity other) {
    return (pos.x - entityWidth/2 < other.pos.x + other.entityWidth/2 &&
            pos.x + entityWidth/2 > other.pos.x - other.entityWidth/2 &&
            pos.y - entityHeight/2 < other.pos.y + other.entityHeight/2 &&
            pos.y + entityHeight/2 > other.pos.y - other.entityHeight/2);
  }
  
  
  
  
}
