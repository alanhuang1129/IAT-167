class Projectile {
  //fields
  PVector projPosition, velocity, dim;
  boolean isAlive;
  float rotation;
  PVector direction;
  
  Projectile(PVector bulletPos, PVector bulletVel) {
    projPosition = bulletPos;
    velocity = bulletVel;
    dim = new PVector(15, 1);
    isAlive = true;
  }
  Projectile(PVector bulletPos, PVector bulletVel, float rot, PVector dir) {
    projPosition = bulletPos;
    velocity = bulletVel;
    rotation = rot;
    direction = dir;
    dim = new PVector(15, 1);
    isAlive = true;
    
    //Trajectory calculation
      //Convert bulletVel to scalar
    float velocityScalar = velocity.mag();
    velocity = direction.mult(velocityScalar);
    
  }
  
  void moveProjectile() {
    projPosition.x += velocity.x;
    projPosition.y += velocity.y;
  }
  
  boolean checkWalls() {
    int bulletPosX = (int)projPosition.x;
    int bulletPosY = (int)projPosition.y;
    return (bulletPosX < 0 || bulletPosX > 1600 || bulletPosY < 0 || bulletPosY > 1000);
  }
  void update() {
    moveProjectile();
    drawProjectile();
    if (checkWalls() || !isAlive) {
      p1.projectiles.remove(this);
      
    }
    
  }
  void drawProjectile() {
    stroke(255, 255, 0);
    strokeWeight(5);
    pushMatrix();
    //translate(position.x, position.y);
    
    translate(projPosition.x + 5, projPosition.y - 10); //With offset for handgun
    rotate(rotation);
    //rect(100, 0, dim.x, dim.y);
    rect(-40, 0, dim.x, dim.y);
    //line(-3, 0, 3, 0);
    popMatrix();
    
    noStroke();
  }
  void hit(BasicEnemy enemy) {
    //enemy variables
    int eWidth = enemy.getWidth();
    int eHeight = enemy.getHeight();
    int ePosX = (int)enemy.getPosition().x;
    int ePosY = (int)enemy.getPosition().y;
   
    //if(position.x > eLeft && position.x < eRight && position.y > eTop && position.y < eBot)
    //Player projectile hits enemy
    if(abs(projPosition.x - ePosX) < dim.x/2 + eWidth/2 && abs(projPosition.y - ePosY) < dim.y/2 + eHeight/2){
      if(p1.gunMode == 0) {
        enemy.decreaseHealth(1);
      }
      if(p1.gunMode == 1) {
        enemy.decreaseHealth(0.2);
      }
      enemy.movementSpeedStun();
      isAlive = false;
    }
  }
  void hit(Player p1) {
    //player variables
    int pWidth = p1.getWidth();
    int pHeight = p1.getHeight();
    int pPosX = (int)p1.getPosition().x;
    int pPosY = (int)p1.getPosition().y;
    
    if(abs(projPosition.x - pPosX) < dim.x/2 + pWidth/2 && abs(projPosition.y - pPosY) < dim.y/2 + pHeight/2){
      p1.decreaseHealth(9);
      isAlive = false;
    }
  }

  void receiveDirection(PVector directionVector) {
    direction = directionVector;
  }
  void receiveAngle(float angle) {
    rotation = angle;
  }
  //Any removal of the projectile is conducted within the main draw loop
}
