//Keyboard controls
float speed = 2;
PVector upAcc = new PVector(0, -speed);
PVector downAcc = new PVector(0, speed);
PVector leftAcc = new PVector(-speed, 0);
PVector rightAcc = new PVector(speed, 0);
boolean up, down, left, right;
boolean mouseReleased = false;
void keyPressed() {
  if (key == 'w') up = true;
  else if (key == 's') down = true;
  else if (key == 'a') left = true;
  else if (key == 'd') right = true;
  
  if (key == 'b' && craftMenu.open == false) craftMenu.open = true;
  else if (key == 'b' && craftMenu.open == true) craftMenu.open = false;
}
void keyReleased() {
  if (key == 'w') up = false;
  else if (key == 's') down = false;
  else if (key == 'a') left = false;
  else if (key == 'd') right = false;
  
}
//Mouse controls
void mousePressed() {
  if (mouseButton == LEFT) {
    p1.attack = true;
    p1.pickaxeReset = false;
    mouseReleased = false;
  }
}
void mouseReleased() {
  p1.attack = false;
  mouseReleased = true;
}
