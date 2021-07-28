//Boss is  tracking projectile, projectile is also not getting deleted at walls

class BossEnemy extends BasicEnemy {
  
  ArrayList<Projectile> bossProjectiles = new ArrayList<Projectile>();
  int projectileTimer = -1;
  
  BossEnemy(PVector position, PVector velocity) {
    super(position, velocity);
    deathTimer = 180; //set death timer to 180 (3 seconds) after it dies
    health = 16;
    alive = true;
    shieldScale = 3;
  }
  
  
  void checkProjectiles(Player player1) {
    for (int i = 0; i < bossProjectiles.size(); i++) {
      Projectile currBossProjectile = bossProjectiles.get(i);
      currBossProjectile.update();
      currBossProjectile.hit(player1);
      if(currBossProjectile.checkWalls() || !currBossProjectile.isAlive) {
        bossProjectiles.remove(currBossProjectile);
      }
      
      if (currBossProjectile.checkWalls()) {
        currBossProjectile.isAlive = false;
      }
    }
  }
  
  void drawEnemy() {
    scaleValue = 3.0;
    super.drawEnemy();
    
  }
  void update() {
    if (health <= 0 && collectScore == false) { //Score keeping
      for (int i = 0; i < 10; i++) { //Boss is worth 10x the score
        playerScore.incrementScore();
      }
      collectScore = true;
      alive = false;
    }
    super.update();
    checkProjectiles(p1);
    if (projectileTimer == -1 && alive == true) {
      fireProjectile();
      projectileTimer = 90;
    }
    projectileTimer--;
  }
  
  void killed() {
    if (health <= 0) {
      enemies.remove(this);
      //for (int i = 0; i < 10; i++) { //Boss is worth 10x the score
      //  playerScore.incrementScore();
      //}
    }
  }
  
  void moveCharacter(){
    super.moveCharacter();
  }
  
  void fireProjectile() {
    PVector directionVector = new PVector(p1.position.x - position.x, p1.position.y - position.y);
    directionVector.normalize();
    directionVector.mult(1);
    
    PVector positiveX = new PVector(1, 0); //positive x-axis
    PVector negativeX = new PVector(-1, 0);
    float angle = 0;
    //angle is split between two cases, because angleBetween gives the reference angle and will not return a negative angle
    if (p1.position.y < position.y) {
      angle = PVector.angleBetween(negativeX, directionVector);
    }
    if (p1.position.y >= position.y) {
      angle = PVector.angleBetween(positiveX, directionVector);
    }
    
    
    bossProjectiles.add(new Projectile(new PVector(position.x, position.y), new PVector(-15, 0), angle, directionVector));
  }
}
