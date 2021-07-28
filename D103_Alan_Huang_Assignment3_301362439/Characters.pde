class Characters {
  //fields
  PVector position;
  PVector velocity;
  float health;
  int charWidth;
  int charHeight;
  boolean alive;
  int movementSpeed;
  
  //Constructors
  Characters() {
    position = new PVector(0, 0);
    velocity = new PVector(0, 0);
    health = 1;
    charWidth = 0;
    charHeight = 0;
    alive = true;
    movementSpeed = 1;
  }
  Characters(PVector pos, PVector vel) {
    position = pos;
    velocity = vel;
    alive = true;
    movementSpeed = 1;
  }
  
  Characters(PVector pos, PVector vel, int health, int cWidth, int cHeight) {
    position = pos;
    velocity = vel;
    this.health = health;
    charWidth = cWidth;
    charHeight = cHeight;
    alive = true;
    movementSpeed = 1;
  }
  
  void moveCharacter() {
    position.add(velocity);
  }
  
  void accelerate(PVector accelerator) {
    velocity.add(accelerator);
  }
  
  void drawCharacter() { //Draw a rectangle as a placeholder
    fill(255, 255, 0);
    strokeWeight(1);
    stroke(0);
    rect(position.x - charWidth/2, position.y - charHeight/2, charWidth, charHeight);
  }
  
  int getWidth() {
    return charWidth;
  }
  int getHeight() {
    return charHeight;
  }
  PVector getPosition() {
    return position;
  }
  
  boolean hitCharacter(Characters chars) {
    //This is all assuming the position is the center of the width x height box
    //0.3 is used because of scaling issues on the character model
    
    //chars variables
    int charsWidth = (int)(chars.getWidth()*0.3);
    int charsHeight = (int)(chars.getHeight()*0.3);
    int charsPosX = (int)chars.getPosition().x;
    int charsPosY = (int)chars.getPosition().y;
    
    //chars - left, right, top, and bottom boundaries
    int charsLeft = charsPosX - charsWidth/2;
    int charsRight = charsPosX + charsWidth/2;
    int charsTop = charsPosY - charsHeight/2;
    int charsBot = charsPosY + charsHeight/2;
    //this object's left, right, top, and bottom boundaries
    int thisLeft = (int)position.x - (int)(0.3*(charWidth/2));
    int thisRight = (int)position.x + (int)(0.3*(charWidth/2));
    int thisTop = (int)position.y - (int)(0.3*(charHeight/2));
    int thisBot = (int)position.y + (int)(0.3*(charHeight/2));
    
    //return this boolean expression that checks the boundaries
    return (thisRight > charsLeft && //Right side of this object intersects with left side of character object
        thisBot > charsTop && //Bottom of this object intersects with top of character object
        charsRight > thisLeft && //Left side of this object intersects with right side of character object
        charsBot > thisTop); //Top of this object intersects with bottom of character object
  }
  
  void decreaseHealth(float damage) {
    health -= damage;
  }
  
  void checkWalls() {
    int x = (int)position.x;
    int y = (int)position.y;
    if (x + charWidth/2 < 0) { //Left boundary
      position.x = 1600 + charWidth/2; //pop back at the right side
    }
    if (x - charWidth/2 > 1600) { //Right boundary
      position.x = 0 - charWidth/2; //pop back at the left side
    }
    if (y + charHeight/2 < 0) { //Top boundary
      position.y = 1000 + charHeight/2; //pop back at the bottom
    }
    if (y - charHeight/2 > 1000) { //Bottom boundary
      position.y = 0 - charHeight/2; //pop back at the top
    }
  }
  void update() {
    moveCharacter();
    checkWalls();
    if (health <= 0) {
      alive = false;
    }
  }
}
