//Note to self: 
//  Character Model
//  Sound effects - music included - check
//  health pack in chest - check
//  Winning exit - check
//  Dying - check
//  Start menu and end menu - check


//Milestone 3 Notes:
//New features: Three maps are currently fully implemented
//Added three types of ores: Coal, Iron, Gold
//  -All ores are needed to craft more powerful tools that will help you proceed
//Thoroughly developed the crafting menu (press 'b') (may add more if I want to (like a key for a treasure chest))
//Player has multiple types of pickaxes: Stone Pickaxe (Starter), Iron Pickaxe, Gold Pickaxe
//Player has three different swing states - Critical hit, Hit, No swing (Player needs to charge the pickaxe swing enough for it to damage anything, holding it longer can result in a critical hit on the swing)
//  -Critical hits deal double damage (May or may not change critical multiplier)
//Rocks/Ores now give feedback when hit, regular hits will flash yellow and critical hits will flash red
//Item drops have their own respective colors
//Collision with rocks have been "fixed", there are some bugs but I think this is enough (too hard to solve the issue)

//Further Implementations: 
//  Player needs to die when no health
//  May change the concept of an "ENEMY" - possibly make it a pillar that will damage players by pulsing an attack in a radius (With animation)
//  More rock-like objects with more health (scaling exponentially) that will surround the goal exit, so you would require a gold pickaxe to break through it or else it will take a REALLY long time
//  Create the rest of the maps (finish off the 3x3 map grid) with resources - Easily digit map more maps
//  May or may not ditch the idea of a treasure chest
//  Finally create a character for the player model (and enemies if I don't change the concept of it)
//  Implement the GOAL exit
//  Possible rock/ore randomizer in the digitmap



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


void setup() {
  size(1600, 1000);

  p1 = new Player(new PVector(200, height/2));
  //p1.setPickaxeType(p1.DIAMOND_PICKAXE);
  gw = new GameWorld(state[row][column]);
  craftMenu = new Menu();
  loadAssets();
  mineTheme.play(0);
  //chest = new Chest(new PVector(400, height/2), 2);
  p1.materials.add(new Material(IRON_KEY));
}

void draw() {
  
  timer++;
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
    clearLevel();
    
    gw = new GameWorld(state[row][column]);
    switchLevel = false;
  }
  
  switch(menuStates) {
    case START_MENU:
      startMenu();
      break;
    case GAMEPLAY:
      if (initializeWorld == false) {
        gw = new GameWorld(state[row][column]);
        initializeWorld = true;
      }
      gamePlay();
      break;
    case LOSE_MENU:
      loseMenu();
      break;
    case WIN_MENU:
      winMenu();
      break;
  }
  
  
  //switch(state[row][column]) {
  //  //case LEVEL_TWO_ONE:
  //  //  gamePlay();
  //  //  break;
  //  //case LEVEL_TWO_TWO:
  //  //  gamePlay();
  //  //  break;
  //  //case LEVEL_ONE_TWO:
  //  //  break;
  //  default:
  //    gamePlay();
  //}
  
  craftMenu.update();
}

void gamePlay() {
  //THIS CODE HAS REDUCED THE FRAME LAG BY SO MUCH - less gw.drawMe calls = less lag (therefore I can fit more objects into it)
  if (timer % 2000000 == 0) { //Although I don't really understand why it works properly with such a high interval
    gw.drawMe(p1);
  }
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
  
  for(int i = 0; i < gw.objects.size(); i++) {
    StationaryObject currObject = gw.objects.get(i);
    currObject.update();
  }
  //reset status
  p1.hitFeedback = false;
  p1.criticalHitFeedback = false;
  
  drawExits();
  p1.drawHealthBar();
  drawHelper();
}

void drawHelper() {
  textSize(32);
  textAlign(CENTER);
  fill(255, 0, 0);
  text("Press b to craft", 1400, 50);
  //Swing indicators
  if (p1.pickaxeChargeTime > 30 - 10*(p1.pickaxeType - 1)){
    fill(255, 255, 0);
    text("Swing charged", 1400, 100);
  }
  if (p1.pickaxeChargeTime > 50 - 10*(p1.pickaxeType - 1)) {
    fill(161, 10, 10);
    text("Critical Swing charged", 1400, 150);
  }
  fill(255, 0, 0);
}
void clearInventory() {
  int numMaterials = p1.materials.size();
  for (int i = 0; i < numMaterials; i++) {
    Material currMaterials = p1.materials.get(0);
    p1.materials.remove(currMaterials);
  }
}

void clearLevel() {
  //Clear enemies from previous level
  int numEnemies = enemies.size();
  for (int i = 0; i < numEnemies; i++) {
    Enemy currEnemy = enemies.get(0);
    enemies.remove(currEnemy);
  }
  //Clear item drops from previous level
  int numItemDrops = itemDrops.size();
  for (int i = 0; i < numItemDrops; i++) {
    ItemDrop currItem = itemDrops.get(0);
    itemDrops.remove(currItem);
  }
}

void startMenu() {
  background(255);
  textAlign(CENTER);
  textFont(titleFont);
  textSize(72);
  text("Miner's Haven", width/2, 200);
  textSize(20);
  text("Objective: Find a way out!", width/2, 300);
  if (startMenu == false) {
    menuButtons.add(new Button(new PVector(width/2, height/2 + 50), new PVector(200, 100), "Play", 1));
    startMenu = true;
  }
  for (int i = 0; i < menuButtons.size(); i++) {
    Button currButton = menuButtons.get(i);
    currButton.drawMe();
    if (currButton.buttonNumber == 1 && currButton.detectClick()) {
      reset();
      menuButtons.remove(currButton);
      startMenu = false;
      menuStates = GAMEPLAY;
    }
  }
}

void loseMenu() {
  background(0);
  textAlign(CENTER);
  textFont(titleFont);
  textSize(72);
  text("GAME OVER", width/2, 200);
  if(loseMenu == false) {
    menuButtons.add(new Button(new PVector(width/2, height/2 - 100), new PVector(200, 100), "Main Menu", 2));
    loseMenu = true;
  }
  for (int i = 0; i < menuButtons.size(); i++) {
    Button currButton = menuButtons.get(i);
    currButton.drawMe();
    if (currButton.buttonNumber == 2 && currButton.detectClick()) {
      reset();
      menuButtons.remove(currButton);
      loseMenu = false;
      menuStates = START_MENU;
    }
  }
}

void winMenu() {
  background(255, 255, 0);
  textAlign(CENTER);
  textFont(titleFont);
  textSize(72);
  text("You Escaped!", width/2, 200);
  if (winMenu == false) {
    menuButtons.add(new Button(new PVector(width/2, height/2 - 100), new PVector(200, 100), "Replay", 3));
    winMenu = true;
  }
  for (int i = 0; i < menuButtons.size(); i++) {
    Button currButton = menuButtons.get(i);
    currButton.drawMe();
    if (currButton.buttonNumber == 3 && currButton.detectClick()) {
      reset();
      menuButtons.remove(currButton);
      winMenu = false;
      menuStates = START_MENU;
    }
  }
}

void reset() {
  p1.health = p1.maxHealth;
  p1.updateHealthPercentage();
  p1.setPickaxeType(p1.STONE_PICKAXE);
  p1.pos = new PVector(200, height/2);
  p1.isAlive = true;
  craftMenu.hasFurnace = false;
  craftMenu.hasIronPickaxe = false;
  craftMenu.hasGoldPickaxe = false;
  craftMenu.hasDiamondPickaxe = false;
  craftMenu.addButtons = false;
  clearLevel();
  clearInventory();
  row = 1;
  column = 0;
  winState = false;
  initializeWorld = false;
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
