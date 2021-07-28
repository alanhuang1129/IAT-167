Player p1;
BasicEnemy e1;
ArrayList<BasicEnemy> enemies = new ArrayList<BasicEnemy>();
ArrayList<ItemPickup> pickupBoxes = new ArrayList<ItemPickup>();
Score playerScore;

//PVector pos1 = new PVector(100, 200);
int go = 0;
int timer = 0;
char[] keys; //used for simultaneous key presses
int enemiesLimit = 10;
int respawnTimer = 60;
boolean bossSpawned = false;
boolean bossDied = false;
boolean gunSpray = false;
int pistolReload = 1;
int rifleReload = 1;
int reloadTimer = 60;
boolean reloading = false;
int pistolCapacity = 12;
int rifleCapacity = 60;
int cutSceneTimer = 180;
int cutSceneTimer2 = 180;

void setup() {
  size(1600, 1000);
  //p1 = new Player(new PVector(width/2, height/2), new PVector(0, 0), 10, 50, 50);
  p1 = new Player(new PVector(width/2, height/2), new PVector(0, 0));
  for (int i = 0; i < enemiesLimit; i++) {
    enemies.add(new BasicEnemy(new PVector(random(100, 500), random(100, 500)), new PVector(random(-5, 5), random(-5, 5) )));
  }
  playerScore = new Score(new PVector(800, 100));
}

void draw() {
  if (startMenu) {
    drawStartMenu();
  }
  else {
    background(38, 158, 50);
    
      if(p1.alive){
        //Character Movement
      if(up || left || right || down) p1.movingAnimation(1);
      else p1.movingAnimation(0);
      if(up) p1.accelerate(upAcc);
      if(left) {
        p1.accelerate(leftAcc);
        p1.setInversion(-1);
      }
      if(right) {
        p1.accelerate(rightAcc);
        p1.setInversion(1);
      }
      if(down) p1.accelerate(downAcc);
      p1.update();
    }
    if (reloading == true) { //Reload gun
      fill(255, 0, 0);
      textAlign(CENTER);
      text("RELOADING...", 1400, 100);
      reloadTimer--;
      if (reloadTimer == -1) {
        reloading = false;
        reloadTimer = 60;
        pistolReload = 1;
        rifleReload = 1;
      }
    }
    if (gunSpray == true && rifleReload % (rifleCapacity + 1) != 0 && !reloading && p1.alive) { //Assault Rifle fire
      p1.fireProjectile();
      p1.setMuzzleFlash(true);
      rifleReload++;
    }
    if(rifleReload % (rifleCapacity + 1) == 0) {
      reloading = true;
    }
    
    //Enemy iterations
    for (int i = 0; i < enemies.size(); i++) {
      BasicEnemy currEnemy = enemies.get(i);
      currEnemy.update();
    }
  
    if (enemies.size() < enemiesLimit && playerScore.getScore() < 1000) { // respawn of basic enemies
      respawnTimer--;
      if (respawnTimer == -1) {
        respawnTimer = 60;
        enemies.add(new BasicEnemy(new PVector(random(100, 500), random(100, 500)), new PVector(random(-5, 5), random(-5, 5) )));
      }
    }
  
    if (playerScore.getScore() >= 1000 && bossSpawned == false && cutSceneTimer != -1) {
      cutSceneTimer--;
      fill(0, 255, 255);
      textAlign(CENTER);
      text("The Boss is Arriving...", width/2, height/4);
    }
    if (playerScore.getScore() >= 1000 && bossSpawned == false && cutSceneTimer == -1) { //Enemy spawn condition - 1000 points
      //Clear initial enemies
      int currentAmount = enemies.size();
      for(int i = 0; i < currentAmount; i++) {
        enemies.remove(enemies.get(0));
      }
    
      enemies.add(new BasicEnemy(new PVector(1600, 100), new PVector(-8, 0)));
      enemies.add(new BasicEnemy(new PVector(1600, 200), new PVector(-8, 0)));
      enemies.add(new BasicEnemy(new PVector(1600, 300), new PVector(-8, 0)));
      enemies.add(new BasicEnemy(new PVector(1600, 400), new PVector(-8, 0)));
      //Boss spawn
      enemies.add(new BossEnemy(new PVector(1600, 500), new PVector(-2, 0)));
      enemies.add(new BasicEnemy(new PVector(1600, 600), new PVector(-8, 0)));
      enemies.add(new BasicEnemy(new PVector(1600, 700), new PVector(-8, 0)));
      enemies.add(new BasicEnemy(new PVector(1600, 800), new PVector(-8, 0)));
      enemies.add(new BasicEnemy(new PVector(1600, 900), new PVector(-8, 0)));
      
      bossSpawned = true;
    }
    if (playerScore.getScore() >= 1000 && bossSpawned == true && enemies.size() == 0) { //boss wave has died
      bossDied = true;
    }
    if (bossDied && cutSceneTimer2 != -1) {
      cutSceneTimer2--;
      fill(0, 255, 255);
      textAlign(CENTER);
      text("The Mother Penguin has died, Penguins will now target you, Good Luck", width/2, height/4);
    }
    
    if (bossDied && cutSceneTimer2 == -1) {
      upAcc = new PVector(0, -5);
      downAcc = new PVector(0, 5);
      leftAcc = new PVector(-5, 0);
      rightAcc = new PVector(5, 0);
      
      if (enemies.size() < enemiesLimit) {
        float spawnPoint = random(0, 200);
        if (spawnPoint < 50) {
          enemies.add(new BasicEnemy(new PVector(0, 0), new PVector(-10, 0), true));
        }
        if (spawnPoint >= 50 && spawnPoint < 100) {
          enemies.add(new BasicEnemy(new PVector(0, 1000), new PVector(-10, 0), true));
        }
        if (spawnPoint >= 100 && spawnPoint < 150) {
          enemies.add(new BasicEnemy(new PVector(1600, 0), new PVector(-10, 0), true));
        }
        if (spawnPoint >= 150 && spawnPoint < 200) {
          enemies.add(new BasicEnemy(new PVector(1600, 1000), new PVector(-10, 0), true));
        }
      }
      
    }
    
    //if (go == 1) {
    //  //PVector accel = new PVector(random(-10, 10), random(-10, 10));
    //  //char2.accelerate(accel);
    //  //PVector accelTest = new PVector(30, 30);
    //  //char2.accelerate(accelTest);
    //  char2.update();
    //}
    //if (char1.hitCharacter(char2)) {
    //  println("Character has been hit: " + timer);
    //}
    
    //p1.projectiles.get(0).drawProjectile();
    timer++;
    playerScore.drawScore();
    if ((int)timer == 300) { //spawn at 5 seconds and add every 10 seconds (because timer %= 600)
      pickupBoxes.add(new ItemPickup());
    }
    
    for(int i = 0; i < pickupBoxes.size(); i++) {
      ItemPickup currBox = pickupBoxes.get(i);
      currBox.update();
    }
    
    timer %= 600;
    
    if (!p1.alive) {
      drawEndScreen();
    }
  
  }
}



//void drawBox() {
//  //Med Box
//  pushMatrix();
//  translate(500, 500);
//  stroke(200);
//  strokeWeight(10);
//  fill(220);
//  rect(-25, -25, 50, 50);
//  stroke(0, 255, 0);
//  strokeWeight(5);
//  line(-20, 0, 20, 0);
//  line(0, -20, 0, 20);
  
//  noStroke();
//  popMatrix();
  
//  //Arms Box
//  pushMatrix();
//  translate(500, 500);
//  stroke(200);
//  strokeWeight(10);
//  fill(220);
//  rect(-25, -25, 50, 50);
//  stroke(200);
//  strokeWeight(5);
//  line(-25, -25, 25, 25);
//  line(25, -25, -25, 25);
  
//  noStroke();
//  popMatrix();
//}

void mousePressed() {
  if (mouseButton == LEFT) {
    if(pistolReload % (pistolCapacity + 1) != 0 && p1.gunMode == 0 && !reloading && p1.alive) {
      p1.fireProjectile();
      pistolReload++;
      p1.setMuzzleFlash(true);
    }
    if(pistolReload % (pistolCapacity + 1) == 0) {
      reloading = true;
    }
    
    
    if (p1.gunMode == 1) { //31 - 1 = 30 (Ammo Capacity)
      gunSpray = true;
    }
  }
}
void mouseReleased() {
  p1.setMuzzleFlash(false);
  gunSpray = false;
}
