boolean startMenu = true;

//Start Menu
void drawStartMenu() {
  background(255);
  textSize(32);
  textAlign(CENTER);
  fill(255, 0, 0);
  text("Controls: 1 - Switch to Pistol, 2 - Switch to Assault Rifle (only if you picked it up)", width/2, height/4);
  text("R - Manual Reload, Left Click - Shoot, wasd - Movement", width/2, 3*height/8);
  
  fill(220);
  rect(width/2 - 50, height/2 - 35, 100, 50);
  fill(255);
  if(mouseX > width/2 - 50 && mouseX < width/2 + 50 && mouseY > height/2 - 35 && mouseY < height/2 + 15) {
    fill(255, 255, 0);
    if(mousePressed == true && mouseButton == LEFT) {
      startMenu = false;
    }
  }
  text("Play", width/2, height/2);
}

//Game over
void drawEndScreen() {
  background(0);
  fill(255, 0, 0);
  textSize(32);
  textAlign(CENTER);
  text("GAME OVER", width/2, height/4);
  text("Score: " + playerScore.score, width/2, 3*height/8);
  fill(220);
  rect(width/2 - 150, 3*height/4 - 30, 300, 40);
  fill(255);
  if(mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > 3*height/4 - 30 && mouseY < 3*height/4 + 10) {
    fill(255, 255, 0);
    if(mousePressed == true && mouseButton == LEFT) {
      resetGame();
    }
  }
  text("Play Again?", width/2, 3*height/4);
}

void resetGame() {
  p1.alive = true;
  playerScore.resetScore();
  p1.health = 10;
  p1.hasRifle = false;
  p1.gunMode = 0;
  p1.position = new PVector(width/2, height/2);
  timer = 0;
  bossSpawned = false;
  bossDied = false;
  cutSceneTimer = 180;
  cutSceneTimer2 = 180;
  upAcc = new PVector(0, -2);
  downAcc = new PVector(0, 2);
  rightAcc = new PVector(2, 0);
  leftAcc = new PVector(-2, 0);
  int currentAmount = enemies.size();
  for(int i = 0; i < currentAmount; i++) {
    enemies.remove(enemies.get(0));
  }
  int pickupAmount = pickupBoxes.size();
  for(int i = 0; i < pickupAmount; i++) {
    pickupBoxes.remove(pickupBoxes.get(0));
  }
  //From setup()
  for (int i = 0; i < enemiesLimit; i++) {
    enemies.add(new BasicEnemy(new PVector(random(100, 500), random(100, 500)), new PVector(random(-5, 5), random(-5, 5) )));
  }
}
