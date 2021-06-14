ArrayList<Penguin> penguins = new ArrayList<Penguin>();
float timer = 0.0;

void setup() {
  for (int i = 0; i < 6; i++) {
    penguins.add(new Penguin((int)random(0, 1800), (int)random(0, 1000), 1)); //Random x and y positions with scale of 1
  }
}

void settings() {
  size(1800, 1000);
}

void draw() {
  background(255);
  for (int i = 0; i < penguins.size(); i++) {
    Penguin currPenguin = penguins.get(i);
    currPenguin.drawMe();
    if (timer < 100) {
      currPenguin.moveLeft();
    }
    if (timer > 100 && timer < 200) {
      currPenguin.moveDown();
    }
    if (timer > 200 && timer < 300) {
      currPenguin.moveRight();
    }
    if (timer > 300 && timer < 400) {
      currPenguin.moveUp();
    }
    currPenguin.updateTimer(timer);
  }
  timer += 1;
  timer %= 400;
}
