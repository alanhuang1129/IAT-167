class Menu {
  boolean open;
  
  Menu() {
    open = false;
  }
  
  void update() {
    if (open) {
      drawMe();
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
    text("Furnace - ", 110, 300);
    text("Stone: " + "/8", 300, 300); //Insert player materials here
  }
}
