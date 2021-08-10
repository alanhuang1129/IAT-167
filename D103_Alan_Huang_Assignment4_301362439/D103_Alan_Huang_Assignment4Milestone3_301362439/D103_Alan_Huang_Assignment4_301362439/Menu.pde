class Menu {
  boolean open;
  ArrayList<Button> buttons = new ArrayList<Button>();
  int numStone = 0;
  boolean hasFurnace = false;
  boolean hasIronPickaxe = false;
  boolean hasGoldPickaxe = false;
  
  boolean addButtons = false;
  int buttonDelay = -1;
  
  //button numbers
  final int CRAFT_FURNACE = 1;
  final int CRAFT_IRON_BAR = 2;
  final int CRAFT_IRON_PICKAXE = 3;
  final int CRAFT_GOLD_BAR = 4;
  final int CRAFT_GOLD_PICKAXE = 5;
  
  final int FURNACE_STONE_AMOUNT = 50;
  final int IRON_PICKAXE_IRON_AMOUNT = 15;
  final int GOLD_PICKAXE_GOLD_AMOUNT = 15;
  
  Menu() {
    open = false;
  }
  
  void update() {
    if (addButtons == false) { //menu's setup() for buttons
      buttons.add(new Button(new PVector(300, 290), new PVector(120, 50), "CRAFT", 1)); //Furnace button
      buttons.add(new Button(new PVector(300, 370), new PVector(120, 50), "CRAFT", 2)); //Iron bar button
      buttons.add(new Button(new PVector(330, 470), new PVector(120, 50), "CRAFT", 3)); //Iron Pickaxe button
      buttons.add(new Button(new PVector(300, 570), new PVector(120, 50), "CRAFT", 4));
      buttons.add(new Button(new PVector(330, 670), new PVector(120, 50), "CRAFT", 5));
      addButtons = true;
    }
    
    if (open) {
      drawMe();
      for (int i = 0; i < buttons.size(); i++) {
        Button currButton = buttons.get(i);
        
        //Button Removal Code
        if (currButton.buttonNumber == CRAFT_FURNACE && hasFurnace) {
          buttons.remove(currButton);
        }
        if (currButton.buttonNumber == CRAFT_IRON_PICKAXE && hasIronPickaxe) {
          buttons.remove(currButton);
        }
        
        
        currButton.drawMe();
        if (buttonDelay != -1) {
          buttonDelay--;
        }
        if (currButton.detectClick() && buttonDelay == -1){
          //println("Clicked");
          //do switch case of what the specific button should do switch(currButton.buttonNumber)
          buttonDelay = 10;
          switch(currButton.buttonNumber) {
            case CRAFT_FURNACE:
              if (getAmount(STONE) >= FURNACE_STONE_AMOUNT && !hasFurnace){
                hasFurnace = true;
                //Delete the amount of stone in the player's material inventory
                consumeAmount(STONE, FURNACE_STONE_AMOUNT);
              }
              break;
            case CRAFT_IRON_BAR:
              if (getAmount(COAL) >= 1 && getAmount(IRON) >= 3 && hasFurnace) {
                consumeAmount(COAL, 1);
                consumeAmount(IRON, 3);
                p1.materials.add(new Material(IRON_BAR));
              }
              break;
            case CRAFT_IRON_PICKAXE:
              if (getAmount(IRON_BAR) >= IRON_PICKAXE_IRON_AMOUNT && getAmount(ENEMY_SOUL_DROP) >= 1 && !hasIronPickaxe) {
                consumeAmount(IRON_BAR, IRON_PICKAXE_IRON_AMOUNT);
                consumeAmount(ENEMY_SOUL_DROP, 1);
                hasIronPickaxe = true;
                p1.setPickaxeType(p1.IRON_PICKAXE);
              }
              break;
            case CRAFT_GOLD_BAR:
              if (getAmount(COAL) >= 2 && getAmount(GOLD) >= 3 && hasFurnace) {
                consumeAmount(COAL, 2);
                consumeAmount(GOLD, 3);
                p1.materials.add(new Material(GOLD_BAR));
              }
              break;
            case CRAFT_GOLD_PICKAXE:
              if (getAmount(GOLD_BAR) >= GOLD_PICKAXE_GOLD_AMOUNT && getAmount(ENEMY_SOUL_DROP) >= 5 && !hasGoldPickaxe) {
                consumeAmount(GOLD_BAR, GOLD_PICKAXE_GOLD_AMOUNT);
                consumeAmount(ENEMY_SOUL_DROP, 5);
                hasGoldPickaxe = true;
                p1.setPickaxeType(p1.GOLD_PICKAXE);
              }
            
          }
        }
      }
    }
    
  }
  int getAmount(int type) {
    int amount = 0;
    for (int i = 0; i < p1.materials.size(); i++) {
        Material currMaterial = p1.materials.get(i);
        if (currMaterial.type == type) amount++;
    }
    return amount;
  }
  
  void consumeAmount(int type, int amount) {
    int currAmountConsumed = 0;
    int i = 0;
    while (currAmountConsumed < amount) {
      Material currMaterial = p1.materials.get(i);
        if (currMaterial.type == type) {
          p1.materials.remove(currMaterial); //As the material gets removed, the next object will take the current indices in place - i stays the same, currAmountConsumed increments
          currAmountConsumed++;
        }
        else {
          i++; //Index does not contain the material type, go to next indices
        }
    }
  }
  
  void drawMe() {
    fill(180);
    stroke(0);
    strokeWeight(1);
    rect(20, 20, 800, 900);
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(64);
    text("Crafting Menu", 400, 100);
    textSize(32);
    line(20, 120, 820, 120);
    //Player inventory display - Only crafted goods
    text("Iron Bars: " + getAmount(IRON_BAR), 120, 150);
    text("Gold Bars: " + getAmount(GOLD_BAR), 120, 200);
    
    line(20, 260, 820, 260);
    text("Furnace - ", 110, 300);
    text("Stone: " + getAmount(STONE) + "/" + FURNACE_STONE_AMOUNT , 600, 300); //Insert player materials here
    text("Iron bar - ", 110, 380);
    text("Iron ore: " + getAmount(IRON) + "/3" + "   Coal: " + getAmount(COAL) + "/1", 600, 380);
    text("(REQUIRES FURNACE)", 200, 430);
    if (hasFurnace) text("Acquired", 300, 300);
    text("Iron Pickaxe - ", 140, 480);
    text("Iron bar: " + getAmount(IRON_BAR) + "/" + IRON_PICKAXE_IRON_AMOUNT, 550, 480);
    text("Enemy Soul: " + getAmount(ENEMY_SOUL_DROP) + "/1", 550, 520);
    if (hasIronPickaxe) text("Acquired", 330, 480);
    text("Gold bar - ", 110, 580);
    text("Gold ore: " + getAmount(GOLD) + "/3" + "   Coal: " + getAmount(COAL) + "/2", 600, 580);
    text("(REQUIRES FURNACE)", 200, 630);
    text("Gold Pickaxe - ", 140, 680);
    text("Gold bar: " + getAmount(GOLD_BAR) + "/" + GOLD_PICKAXE_GOLD_AMOUNT, 550, 680);
    text("Enemy Soul: " + getAmount(ENEMY_SOUL_DROP) + "/5", 550, 720);
  }
}
