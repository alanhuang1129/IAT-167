//Milestone 2 Notes:
//New features: digit mapping and crafting menu
//Sorry Level 1 features are NOT completely done, there still needs to be design of level (it's just adding 1s in certain places), and the collision for the rock should be fixed
//However there is a lot of structural progress done of the overall game (Because I need to design 9 levels with many more classes to be made)
//Digital mapping of map levels - 3x3 map planned for the future (with goal exit to win game)
//3x3 map already implemented, however only two levels are designed with rocks at the moment (although not final product)
//The only maps that have stuff are the first level and the level on the right of the starting level
//STILL NEED TO FIX ROCK COLLISION METHOD
//Crafting menu is opened by pressing 'b', it is bare bones right now, but there will be buttons and interaction with the player's materials (Need materials class)
//An example of what the materials will be is the item drops from breaking rocks and killing monsters, will give a certain material (ie; stone from rocks) then you can use that to craft something
//There will be ores that give different materials too (like coal, iron, and gold)



//Milestone 1 Notes:
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
//ArrayList<Rock> rocks = new ArrayList<Rock>();
GameWorld gw;
Menu craftMenu;

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

int[][] state = {
                {1, 2, 3},
                {4, 5, 6},
                {7, 8, 9}
              };

final int LEVEL_ONE_ONE = 1;
final int LEVEL_ONE_TWO = 2;
final int LEVEL_ONE_THREE = 3;
final int LEVEL_TWO_ONE = 4;
final int LEVEL_TWO_TWO = 5;
final int LEVEL_TWO_THREE = 6;
final int LEVEL_THREE_ONE = 7;
final int LEVEL_THREE_TWO = 8;
final int LEVEL_THREE_THREE = 9;

int row = 1;
int column = 0;
boolean switchLevel = false;

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
  //for (int i = 0; i < numRocks; i++) {
  //  rocks.add(new Rock(new PVector(random(width/2, width), random(0, height)))); 
  //}
  p1 = new Player(new PVector(200, height/2));
  gw = new GameWorld(state[row][column]);
  craftMenu = new Menu();
}

void draw() {
  //Exit declarations
  if (column == 0) leftExit = false;
  else leftExit = true;
  
  if (column == 2) rightExit = false;
  else rightExit = true;
  
  if (row == 0) topExit = false;
  else topExit = true;
  
  if (row == 2) botExit = false;
  else botExit = true;
  
  background(56, 40, 21);
  
  if (switchLevel == true) {
    gw = new GameWorld(state[row][column]);
    switchLevel = false;
  }
  
  switch(state[row][column]) {
    case LEVEL_TWO_ONE:
    gamePlay();
    break;
    case LEVEL_TWO_TWO:
    gamePlay();
    break;
    default:
    gamePlay();
  }
  
  craftMenu.update();
}

void gamePlay() {
  gw.drawMe(p1);
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
  
  for(int i = 0; i < gw.objects.size(); i++) {
    StationaryObject currObject = gw.objects.get(i);
    currObject.update();
  }
  
  drawExits();
  p1.drawHealthBar();
}

void drawExits(){
  fill(0, 255, 0);
  if (leftExit == true) {
    rect(-p1.pos.x + 1*75 + 0, -p1.pos.y + 14*75 - 30, 5, 60);
    //collision detection
    if (p1.pos.x - p1.entityWidth/2 < -p1.pos.x + 1*75 + 5 &&
        p1.pos.x + p1.entityWidth/2 > -p1.pos.x + 1*75 + 0 &&
        p1.pos.y - p1.entityHeight/2 < -p1.pos.y + 14*75 + 30 &&
        p1.pos.y + p1.entityHeight/2 > -p1.pos.y + 14*75 - 30) {
          //if collided, reposition at the opposite side of the screen (as if entered a new level)
       repositionState = RIGHT_OF_SCREEN;
       p1.repositionPlayer();
       column--;
       switchLevel = true;
    }
  }
  if (rightExit == true) { //REPLACED WIDTH WITH 42*75 (RIGHT BOUNDARY)
    rect(-p1.pos.x + 42*75 - 5, -p1.pos.y + 14*75 - 30, 5, 60);
    if (p1.pos.x - p1.entityWidth/2 < -p1.pos.x + 42*75 &&
        p1.pos.x + p1.entityWidth/2 > -p1.pos.x + 42*75 - 5 &&
        p1.pos.y - p1.entityHeight/2 < -p1.pos.y + 14*75 + 30 &&
        p1.pos.y + p1.entityHeight/2 > -p1.pos.y + 14*75 - 30) {
       repositionState = LEFT_OF_SCREEN;
       p1.repositionPlayer();
       column++;
       switchLevel = true;
    }
  }
  if (topExit == true) {
    rect(-p1.pos.x + 21*75 - 30, -p1.pos.y + 1*75 + 0, 60, 5);
    if (p1.pos.x - p1.entityWidth/2 < -p1.pos.x + 21*75 + 30 &&
        p1.pos.x + p1.entityWidth/2 > -p1.pos.x + 21*75 - 30 &&
        p1.pos.y - p1.entityHeight/2 < -p1.pos.y + 1*75 + 5 &&
        p1.pos.y + p1.entityHeight/2 > -p1.pos.y + 1*75 + 0) {
       repositionState = BOTTOM_OF_SCREEN;
       p1.repositionPlayer();
       row--;
       switchLevel = true;
    }
  }
  if (botExit == true) {
    rect(-p1.pos.x + 21*75 - 30, -p1.pos.y + 25*75 - 5, 60, 5);
    if (p1.pos.x - p1.entityWidth/2 < -p1.pos.x + 21*75 + 30 &&
        p1.pos.x + p1.entityWidth/2 > -p1.pos.x + 21*75 - 30 &&
        p1.pos.y - p1.entityHeight/2 < -p1.pos.y + 25*75 &&
        p1.pos.y + p1.entityHeight/2 > -p1.pos.y + 25*75 - 5) {
       repositionState = TOP_OF_SCREEN;
       p1.repositionPlayer();
       row++;
       switchLevel = true;
    }
  }
}
