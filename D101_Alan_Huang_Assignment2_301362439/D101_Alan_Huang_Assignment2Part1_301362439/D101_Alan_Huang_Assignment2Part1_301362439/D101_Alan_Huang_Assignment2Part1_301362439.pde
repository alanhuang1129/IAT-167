Penguin penguin1;
Penguin penguin2;
float timer = 0.0;

void setup() {
  size(1000, 1000);
  penguin1 = new Penguin(200, 200, 1.0);
  penguin2 = new Penguin();
}
void draw() {
  background(255);
  penguin1.drawMe();
  penguin1.move();
  penguin2.drawMe();
  penguin2.moveLeft();
  
  timer++;
  penguin1.updateTimer(timer);
  penguin2.updateTimer(timer);
  
  
}
