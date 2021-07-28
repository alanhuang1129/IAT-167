boolean up, down, left, right;
PVector upAcc = new PVector(0, -2);
PVector downAcc = new PVector(0, 2);
PVector rightAcc = new PVector(2, 0);
PVector leftAcc = new PVector(-2, 0);

void keyPressed() {
  if(key == 'a') left = true;
  if(key == 'w') up = true;
  if(key == 's') down = true;
  if(key == 'd') right = true;
  if(key == '1') p1.gunMode = 0;
  if(key == '2' && p1.hasRifle) p1.gunMode = 1;
  if(key == 'r') reloading = true; //manual reload
}

void keyReleased() {
  if(key == 'a') left = false;
  if(key == 'w') up = false;
  if(key == 's') down = false;
  if(key == 'd') right = false;
}
