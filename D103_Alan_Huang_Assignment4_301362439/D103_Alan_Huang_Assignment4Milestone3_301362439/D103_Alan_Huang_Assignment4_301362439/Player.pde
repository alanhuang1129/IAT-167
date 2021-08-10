class Player extends Entity {
  final int STONE_PICKAXE = 1;
  final int IRON_PICKAXE = 2;
  final int GOLD_PICKAXE = 3;
  
  int pickaxeType;
  ArrayList<Material> materials = new ArrayList<Material>();
  int attackPower;
  color pickaxeColor;
  
  int maxHealth;
  float healthPercentage;
  int gracePeriod = 60;
  boolean hit = false;
  
  float damp = 0.8;
  
  boolean attack = false;
  float pickaxeRotation = 0.0;
  boolean pickaxeReset = true; //Original position of pickaxe
  PVector pickaxeSwingHitboxCenter;
  int pickaxeSwingHitboxSize;
  int pickaxeChargeTime = 0;
  
  boolean hitFeedback = false; //When hit, emit some form of feedback
  boolean criticalHitFeedback = false;
  
  
  Player(PVector pos) {
    super(pos, new PVector(0, 0));
    health = 10;
    maxHealth = health;
    healthPercentage = 1;
    entityWidth = 100;
    entityHeight = 100;
    
    setPickaxeType(STONE_PICKAXE);
    pickaxeSwingHitboxSize = 150;
  }
  
  void drawMe() {
    //Character for now (need to get character model)
    fill(0, 255, 255);
    pushMatrix();
    translate(pos.x, pos.y);
    scale(turning, 1);
    rect(-entityWidth/2, -entityHeight/2, entityWidth, entityHeight);
    
    rotate(radians(pickaxeRotation));
    //Pickaxe
    pushMatrix();
    translate(50, -20);
    rotate(radians(30));
    //Handle
    fill(102, 51, 0);
    rect(0, 0, 5, 40);
    
    //Pickaxe Head
    fill(pickaxeColor);
    noStroke();
    triangle(3, 5, -20, 18, 2, -5);
    triangle(2, 5, 20, 18, 2, -5);
    popMatrix();
    
    
    popMatrix();
  }
  
  void update() {
    super.update();
    drawMe();
    
    if(mouseButton == LEFT) {
      pickaxeChargeTime++;
    }
    
    vel.mult(damp);
    pickaxeSwingHitboxCenter = new PVector(pos.x + turning*50, pos.y - 20);
    
    for (int i = 0; i < enemies.size(); i++) {
      Enemy currEnemy = enemies.get(i);
      //Collision with enemy
      if (hitCharacter(currEnemy) && gracePeriod == 60) {
        health--;
        updateHealthPercentage();
        hit = true;
      }
      //Swing on enemy
      detectSwing(currEnemy);
    }
    
    for (int i = 0; i < gw.objects.size(); i++) {
      StationaryObject currObject = gw.objects.get(i);
      if (currObject instanceof Rock) {
        detectSwing((Rock)currObject);
      }
    }
    
    if (hit) {
      gracePeriod--;
      if (gracePeriod < 0) {
        gracePeriod = 60;
        hit = false;
      }
    }
    
    
    //Pickaxe animations
    
    //Uncomment code below to see pickaxe swing hitbox
    //fill(255, 0, 255);
    //circle(pickaxeSwingHitboxCenter.x, pickaxeSwingHitboxCenter.y, pickaxeSwingHitboxSize);
    
    if (mouseButton == LEFT && attack == true) {
      pickaxeRotation -= 2;
      if (pickaxeRotation < -60) {
        pickaxeRotation = -60;
      }
    }
    if (attack == false) {
      pickaxeRotation += 20;
      if (pickaxeRotation > 30) {
        pickaxeRotation = 30;
        pickaxeReset = true;
      }
    }
    
    //Reset swing status
    
    
  }
  
  void detectSwing(Entity other) {
    //The pickaxe swing is a circle collision system vs the character model's box collision system, for simplicity, I will just use the other's position
    if (dist(pickaxeSwingHitboxCenter.x, pickaxeSwingHitboxCenter.y, -pos.x + other.pos.x, -pos.y + other.pos.y) < pickaxeSwingHitboxSize && pickaxeReset == false && mouseReleased == true) { //pickaxeReset and mouseReleased are conditions of swinging motion
      other.hitFeedback = hitFeedback;
      other.criticalHitFeedback = criticalHitFeedback;
      //println("detected");
      if (hitFeedback == true) {
        other.health -= attackPower;
      }
      if (criticalHitFeedback == true) {
        other.health -= attackPower;
      }
    }
  }
  void detectSwing(Rock r) {
    if (dist(pickaxeSwingHitboxCenter.x, pickaxeSwingHitboxCenter.y, -pos.x + r.pos.x, -pos.y + r.pos.y) < pickaxeSwingHitboxSize && pickaxeReset == false && mouseReleased == true) {
      r.hitFeedback = hitFeedback;
      r.criticalHitFeedback = criticalHitFeedback;
      if (r.gracePeriodTimer == -1 && r.hitFeedback == true) {
        r.health -= attackPower;
        if (r.criticalHitFeedback == true) { //Additional damage for critical hit
          r.health -= attackPower;
        }
        //println(r.health);
        r.gracePeriodTimer = 30;
      }
    }
  }
  
  void drawHealthBar() {
    //Imported from Lab Challenge 9 of IAT 167
    int healthBarWidth = 200;
    pushMatrix();
    fill(0, 64);
    translate(20, 20);
    rect(0, 0, healthBarWidth, 20); //container for health
    fill(255, 0, 0, 255);
    rect(0, 0, healthBarWidth * healthPercentage, 20); //health bar
    popMatrix();
  }
  
  void updateHealthPercentage() {
    healthPercentage=(float)health/maxHealth;
  }
  
  void repositionPlayer() {
    switch (repositionState) {
      case LEFT_OF_SCREEN:
      pos.x = 100;
      pos.y = height/2;
      break;
      
      case RIGHT_OF_SCREEN:
      pos.x = width - 100;
      pos.y = height/2;
      break;
      
      case TOP_OF_SCREEN:
      pos.x = width/2;
      pos.y = 100;
      break;
      
      case BOTTOM_OF_SCREEN:
      pos.x = width/2;
      pos.y = height - 100;
      break;
    }
  }
  
  void setPickaxeType(int type) {
    //Code for setting attackPower - Exponentially
    pickaxeType = type;
    attackPower = 1;
    for (int i = 0; i < type; i++) {
      attackPower *= 5;
    }
    //Code for setting color of the pickaxe
    switch(type) {
      case STONE_PICKAXE:
        pickaxeColor = color(120);
        break;
      case IRON_PICKAXE:
        pickaxeColor = color(220);
        break;
      case GOLD_PICKAXE:
        pickaxeColor = color(255, 255, 0);
        break;
    }
  }
  
}
