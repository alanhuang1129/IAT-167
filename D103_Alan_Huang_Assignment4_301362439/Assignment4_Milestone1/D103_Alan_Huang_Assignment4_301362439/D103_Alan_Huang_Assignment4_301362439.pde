//HOLD LEFT CLICK TO CHARGE SWING, RELEASE LEFT CLICK TO SWING
//New feature, melee combat style, with item drops, Obstacle clearing gameplay, multiple exits
//NOTE: Actual level 1 will have more rocks, user interface, and character models
//There will also be a different number of exits to teach level, making a Map system 
//(eg: exit on the top of the map, leads to the level mapped above the current level, as well as an exit on the right, leading to the level mapped to the right of the current level)
//There is no current goal state of the game and there is only one state (which is the current state). We can just say for milestone 1, the goal state (end) is the exit on the right. However there is no end screen

ArrayList<Enemy> enemies = new ArrayList<Enemy>();
Player p1;
ArrayList<ItemDrop> itemDrops = new ArrayList<ItemDrop>();
//ArrayList<StationaryObject> objects = new ArrayList<StationaryObject>();
ArrayList<Rock> rocks = new ArrayList<Rock>();

int numEnemies = 1;
int numRocks = 5;

//Map states
int repositionState;
final int LEFT_OF_SCREEN = 1;
final int RIGHT_OF_SCREEN = 2;
final int TOP_OF_SCREEN = 3;
final int BOTTOM_OF_SCREEN = 4;
//Which exits are existing
boolean leftExit = true;
boolean rightExit = true;
boolean topExit = true;
boolean botExit = true;


final int ENEMY_SOUL_DROP = 10;
final int STONE = 1;


void setup() {
  size(1600, 1000);
  for (int i = 0; i < numEnemies; i++ ) {
    enemies.add(new Enemy(new PVector(random(width/2, width),random(0, height)), new PVector(random(-2, 2), random(-2, 2))));
  }
  //for (int i = 0; i < numRocks; i++) {
  //  objects.add(new Rock(new PVector(random(width/2, width), random(0, height)))); 
  //}
  for (int i = 0; i < numRocks; i++) {
    rocks.add(new Rock(new PVector(random(width/2, width), random(0, height)))); 
  }
  
  p1 = new Player(new PVector(100, height/2));
}

void draw() {
  background(255);
  gamePlay();
}

void gamePlay() {
  p1.update();
  
  if (up) p1.accelerate(upAcc);
  if (down) p1.accelerate(downAcc);
  if (left) p1.accelerate(leftAcc);
  if (right) p1.accelerate(rightAcc);
  
  for (int i = 0; i < enemies.size(); i++) {
    Enemy currEnemy = enemies.get(i);
    currEnemy.update();
  }
  
  //for loop for item drops
  for (int i = 0; i < itemDrops.size(); i++) {
    ItemDrop currItemDrop = itemDrops.get(i);
    currItemDrop.update();
  }
  
  //for (int i = 0; i < objects.size(); i++) {
  //  StationaryObject currObject = objects.get(i);
  //  currObject.update();
  //  if (currObject.objectType == currObject.ROCK_TYPE) { //code for rocks
  //  }
  //}
  
  for(int i = 0; i < rocks.size(); i++) {
    Rock currRock = rocks.get(i);
    currRock.update();
    currRock.drawMe();
  }
  
  drawExits();
  p1.drawHealthBar();
}

void drawExits(){
  fill(0, 255, 0);
  if (leftExit == true) {
    rect(0, height/2 - 30, 5, 60);
    //collision detection
    if (p1.pos.x - p1.entityWidth/2 < 5 &&
        p1.pos.x + p1.entityWidth/2 > 0 &&
        p1.pos.y - p1.entityHeight/2 < height/2 + 30 &&
        p1.pos.y + p1.entityHeight/2 > height/2 - 30) {
          //if collided, reposition at the opposite side of the screen (as if entered a new level)
       repositionState = RIGHT_OF_SCREEN;
       p1.repositionPlayer();
    }
  }
  if (rightExit == true) {
    rect(width - 5, height/2 - 30, 5, 60);
    if (p1.pos.x - p1.entityWidth/2 < width &&
        p1.pos.x + p1.entityWidth/2 > width - 5 &&
        p1.pos.y - p1.entityHeight/2 < height/2 + 30 &&
        p1.pos.y + p1.entityHeight/2 > height/2 - 30) {
       repositionState = LEFT_OF_SCREEN;
       p1.repositionPlayer();
    }
  }
  if (topExit == true) {
    rect(width/2 - 30, 0, 60, 5);
    if (p1.pos.x - p1.entityWidth/2 < width/2 + 30 &&
        p1.pos.x + p1.entityWidth/2 > width/2 - 30 &&
        p1.pos.y - p1.entityHeight/2 < 5 &&
        p1.pos.y + p1.entityHeight/2 > 0) {
       repositionState = BOTTOM_OF_SCREEN;
       p1.repositionPlayer();
    }
  }
  if (botExit == true) {
    rect(width/2 - 30, height - 5, 60, 5);
    if (p1.pos.x - p1.entityWidth/2 < width/2 + 30 &&
        p1.pos.x + p1.entityWidth/2 > width/2 - 30 &&
        p1.pos.y - p1.entityHeight/2 < height &&
        p1.pos.y + p1.entityHeight/2 > height - 5) {
       repositionState = TOP_OF_SCREEN;
       p1.repositionPlayer();
    }
  }
}
