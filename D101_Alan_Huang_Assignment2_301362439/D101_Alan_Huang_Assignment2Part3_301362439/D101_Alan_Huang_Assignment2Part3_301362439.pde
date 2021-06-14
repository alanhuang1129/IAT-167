//README: Some penguins are spawned in but you may not see it at first because it is hiding behind an igloo - it is a fixed spawn rate
//      -Overlapping bug (it's not perfect), Future Implementation - I would fix it by implementing a sorting function for the arrayList container and sort by y-positions to prioritize drawing order
//      -If timed in a certain way, penguins may have their death animation but won't be removed. (I believe this is a bug with the looping)
//      -Press 'r' to go back to menu
//      -Some shots fail to hit
//      -Killing Spree text not functioning properly


//Background Variables
color skyDaytime = color(0, 255, 255);
color snowColor = color(255);

//Igloo variables
color iglooOutline = color(240);
final int numIgloos = 5;
int iglooSpawnPoints;
Igloo[] igloos = new Igloo[5];

//Penguins
ArrayList<Penguin> penguins = new ArrayList<Penguin>();

//Main animation variables - Animations in the main loop
int spawnPoints; //Used for a switch case statement
final int spawnDelay = 50; //Fixed time delay
final int deathDelay = 50;
Score score;
PFont scoreFont;
int hit = 0; //if hit > 0, don't increment score
boolean menu = true;
int crosshair = 0;
int reloading = 0;
float reloadTimer = 0.0;
float reloadCoefficient = 4.0; //reload speed
int ammo = 0; // (ammo = 0 -> 5 bullets, ammo = 1 -> 4 bullets, ... 5 = 0 bullets
float recoilTimer = 0.0;
int shot = 0; //shot = 0 -> no recoiling, shot = 1 -> recoil up, shot = 2 -> recoil down
float recoilCoefficient = 5.0; //intensity of recoil
float recoilTime = 5.0; //recoil airtime
float scaleIncrease = 1.1; //Speed multiplifer after every kill
int missCounter = 0;
int hitCounter = 0;

//Snowstorm animation variables
ArrayList<Snowstorm> snowstorms = new ArrayList<Snowstorm>();
float timer = 0.0;

float snowTimer = 0.0;

int delay = 5;

void setup() {
  //scoreFont = createFont("andalemo.ttf", 32);
  //score.setFont(scoreFont);
  //Number of igloos spawn between 1 and 5
  score = new Score(width/2 - 100, 100, 60);
  for (int i = 0; i < numIgloos; i++) {
    iglooSpawnPoints = (int)random(1, 6); //because (1, 5) excludes 5
    switch(iglooSpawnPoints) {
      case 1:
        igloos[i] = new Igloo(width/2 + 50, height/2 + 100, 1.0);
        break;
      case 2:
        igloos[i] = new Igloo(width/2 - 400, height/2  - 100, 0.7);
        break;
      case 3:
        igloos[i] = new Igloo(width/2 + 600, height/2 - 100, 0.7);
        break;
      case 4:
        igloos[i] = new Igloo(width/2 - 600, height/2 + 300, 1.2);
        break;
      case 5:
        igloos[i] = new Igloo(width/2 + 500, height/2 + 300, 1.2);
        break;
      default:
        break;
        
    }
  }
  for (int i = 0; i < 20; i++) {
    snowstorms.add(new Snowstorm(25, i));//(time interval, delay coefficient)
  }
}

void settings() {
  size(1800, 1000);
}

void draw() {
  if (menu == true) {
    drawMenu();
  }
  else {
    drawBackground();
    //println(penguins.size());
    //println("Mouse X = " + mouseX + " Mouse Y = " + mouseY);
    
    //Igloo drawing
    for (int i = 0; i < numIgloos; i++) {
      Igloo currIgloo = igloos[i];
      currIgloo.drawMe();
    }
  
      
    //Penguin Instantiation at random spawn points
    if (penguins.size() < 10) { //If there are less than 10 penguins instantiated
      //create more at a random spawnPoint - Note: Possible spawning at the same place is intentional game design, they will not directly overlap with each other due to delays of spawning
      spawnPoints = (int)random(1,11); //because (1,10) excludes 10
      float delay = timer;
      delay %= spawnDelay + 2;
      if (delay > spawnDelay) {
        switch(spawnPoints) {
          case 1: 
            penguins.add(new Penguin(538, 404, 3, 3, 1, spawnPoints));
            break;
            
          case 2:
            penguins.add(new Penguin(1513, 407, 3, 3, 1, spawnPoints));
            break;
            
          case 3:
            penguins.add(new Penguin(132, 488, 3, 3, 1, spawnPoints));
            break;
            
          case 4:
            penguins.add(new Penguin(1297, 507, 3, 3, 1, spawnPoints));
            break;
            
          case 5:
            penguins.add(new Penguin(978, 536, 3, 3, 1, spawnPoints));
            break;
            
          case 6:
            penguins.add(new Penguin(296, 787, 3, 3, 1, spawnPoints));
            break;
            
          case 7:
            penguins.add(new Penguin(652, 752, 3, 3, 1, spawnPoints));
            break;
            
          case 8:
            penguins.add(new Penguin(1715, 644, 3, 3, 1, spawnPoints)); 
            break;
            
          case 9:
            penguins.add(new Penguin(1715, 644, 3, 3, 1, spawnPoints));
            break;
            
          case 10:
            penguins.add(new Penguin(42, 982, 3, 3, 1, spawnPoints));
            break;
            
          default:
            break;
        }
      }
    }
    //Penguin Drawing
    for(int i = 0; i < penguins.size(); i++) {
      Penguin currPenguin = penguins.get(i);
      currPenguin.drawMe();
      //currPenguin.moveUp();
      currPenguin.updateTimer(timer);
      if (reloading == 0) {
        currPenguin.setReloading(false);
      }
      if (reloading == 1) {
        currPenguin.setReloading(true);
      }
      
      //Looping
      if(currPenguin.getX() < -100) { //loop back to the right
        currPenguin.setX(width + 100);
      }
      if(currPenguin.getX() > width + 100) { //loop back to the left
        currPenguin.setX(-100);
      }
      if (currPenguin.getY() > 1137) { //loop back up
        currPenguin.setY(3*height/8 - 45); //3*height/8 = top of snow floor
      }
      if (currPenguin.getY() < 3*height/8) {//loop back down
        currPenguin.setY(1050);
      }
      //Does not really work properly :(
      boolean hitAtleastOnce = false;
      for (int j = 0; j < penguins.size(); j++) {
        Penguin currPenguin3 = penguins.get(i);
        if(currPenguin3.detectHit() == true) {
          hitAtleastOnce = true;
        }
      }
      
      //Deletion of penguin
      if (currPenguin.detectHit() == true && ammo < 5 && reloading == 0) {
        currPenguin.dying();
        if(currPenguin.getHit() < 1) {
          score.incrementScore();
          for(int j = 0; j < penguins.size(); j++) { //As you kill one, the other remaining ones will increase their speed
            Penguin currPenguin2 = penguins.get(j);
            currPenguin2.buffSpeeds(scaleIncrease);
          }
          currPenguin.incrementHit();
        }
      }

      //Miss detection
      if (shot == 1 && hitAtleastOnce && reloading == 0 && ammo < 5) {
        missCounter = 0;
        hitCounter++;
      }
      if (shot == 1 && !hitAtleastOnce && reloading == 0 && ammo < 5){
        missCounter++;
        hitCounter = 0;
      }
      
      boolean isHeDying = currPenguin.deathState();
      if (isHeDying) {
        if (currPenguin.getDeathTimer() > deathDelay) {
          penguins.remove(currPenguin);
        }
        currPenguin.incrementDeathTimer();
      }
      
      //Movement - Each spawnpoint should have a different movement pattern
      int movementCase = currPenguin.getMovementCase();
      switch(movementCase) { //Dead penguins don't move, so there is no movement for isHeDying = true
        //Note: timer value goes up to 399 then resets to 0
        //And speed changes should always be in tight ranges so it doesnt call unnecessarily (since it's a float == expressions might not be detected)
        case 1:
          if (!isHeDying) {
            currPenguin.moveRight();
          }
          break;
          
        case 2:
          if (!isHeDying) {
            if (timer < 200) {
              currPenguin.moveRight();
            }
            if (timer > 200) {
              currPenguin.moveLeft();
            }
          }
          break;
          
        case 3:
          if (!isHeDying) {
            if (timer < 100) {
              currPenguin.moveRight();
            }
            if (timer > 100 && timer < 200) {
              currPenguin.moveDown();
            }
            if (timer > 200 && timer < 300) {
              currPenguin.moveUp();
            }
            if (timer > 300) {
              currPenguin.moveLeft();
            }
          }
          break;
          
        case 4:
          if (!isHeDying) {
            if (timer < 100) {
              currPenguin.moveRight();
              currPenguin.moveDown();
            }
            if (timer > 100 && timer < 200) {
              currPenguin.moveRight();
              currPenguin.moveUp();
            }
            if (timer > 198 && timer < 201) {
              currPenguin.changeXSpeed(6); //Speed Demon Mode
            }
            if (timer > 200) {
              currPenguin.moveLeft();
            }
            if (timer > 300 && timer < 303) {
              currPenguin.changeXSpeed(3); //Speed Demon Mode on cooldown
            }
          }
          break;
          
        case 5:
          if (!isHeDying) {
            if (timer > 0 && timer < 3) {
              currPenguin.changeXSpeed(5);
            }
            if (timer < 50) {
              currPenguin.moveRight();
            }
            if (timer > 100 && timer < 103) {
              currPenguin.changeYSpeed(4);
            }
            if (timer > 100 && timer < 200) {
              currPenguin.moveUp();
            }
            if (timer > 200 && timer < 300) {
              currPenguin.moveDown();
              currPenguin.moveRight();
            }
            if (timer > 300 && timer < 303) {
              currPenguin.changeXSpeed(2);
              currPenguin.changeYSpeed(2);
            }
            if (timer > 300) {
              currPenguin.moveLeft();
            }
          }
          break;
          
        case 6:
          if (!isHeDying) {
            if (timer < 200) {
              currPenguin.moveRight();
              currPenguin.moveDown();
            }
            if (timer > 200) {
              currPenguin.moveLeft();
              currPenguin.moveUp();
            }
          }
          break;
          
        case 7:
          if (!isHeDying) {
            if (timer < 100) {
              currPenguin.moveLeft();
            }
            if (timer > 200 && timer < 203) {
              currPenguin.changeXSpeed(7);
            }
          }
          break;
          
        case 8:
          if (!isHeDying) {
            if (timer < 100) {
              currPenguin.moveLeft();
              currPenguin.moveUp();
            }
            if (timer > 150) {
              currPenguin.moveLeft();
            }
          }
          break;
          
        case 9:
          if (!isHeDying) {
            currPenguin.moveLeft();
          }
          break;
          
        case 10:
          if (!isHeDying) {
            currPenguin.moveDown();
          }
          break;
        default:
          break;
          
      }
      
      
     //Igloo Overlap Drawing - Has to be nested (This is so when penguins pass through the igloos, get hidden under the igloos
      for(int j = 0; j < numIgloos; j++) {
        Igloo currIgloo = igloos[j];
        //Overlap Conditions - igloo's proximity to the current penguin and the corresponding height priority (respectively)
        boolean overlapConditions = currIgloo.detectProximity(currPenguin.getX(), currPenguin.getY()) && currPenguin.getY() < currIgloo.getY();
        if (overlapConditions) {
          currIgloo.drawMe();
        }
      }
    }
    
    timer %= 400;
    //println(timer);
    drawSnowstorm();
    if (crosshair == 1) {
      drawCrosshair();
    }
    //Killing Spree counter
    if (hitCounter > 0) {
      fill(255, 0, 255);
      textSize(40);
      text("Killing Spree: " + hitCounter, 200, 100);
    }
    
    
    implementAmmoSystem();
    if (shot == 1) {
      recoilTimer += 1; //recoil crosshair launches up
      if(recoilTimer > recoilTime) { //Recoil Speed
        shot = 2;
      }
    }
    if (shot == 2) {
      recoilTimer -= 1; //recoil goes back down
      if(recoilTimer < 0) {
        shot = 0;
        recoilTimer = 0.0;
      }
    }
    
    fill(0, 255, 0);
    score.displayScore();
    snowTimer += 1;
    timer += 1;
    reloadTimer += 1;
  }
}

void keyPressed() {
  if (key == 'r') {
    for (int i = 0; i < snowstorms.size(); i++) {
      snowstorms.remove(i);
    }
    menu = true;
    cursor();
    setup();
  }
}

void mouseDragged() {
  for (int i = 0; i < penguins.size(); i++) {
    Penguin currPenguin = penguins.get(i);
    currPenguin.setMouseHold(true);
  }
}

void mouseReleased() {
  for (int i = 0; i < penguins.size(); i++) {
    Penguin currPenguin = penguins.get(i);
    currPenguin.setMouseHold(false);
  }
}

void mousePressed() {
  if(mouseX - width/2 > -300 && mouseX - width/2 < 300 && mouseY - height/2 > -80 && mouseY - height/2 < 20 && menu == true) {
    crosshair++;
    crosshair %= 2; // crosshair = 0 is off, crosshair = 1 is on
  }
  if (ammo < 5) {
    ammo++;
  }
  if (reloading == 0 && menu == false) {
    shot = 1;
  }
  recoilTimer = 0.0;
}

//Crosshair for sniper mode
void drawCrosshair() {
  noCursor();
  pushMatrix();
  translate(mouseX, mouseY - recoilTimer*recoilCoefficient);
  
  if (shot == 1) { //Muzzle flash
    fill(255, 255, 0);
    pushMatrix();
    translate(0, 400);
    rotate(PI/3);
    ellipse(0, 0, 500, 100);
    rotate(PI/4);
    ellipse(0, 0, 500, 100);
    popMatrix();
  }
  
  noFill();
  stroke(0);
  strokeWeight(2300);
  circle(0, 0, 3000);

  strokeWeight(1);
  line(-500, 0, 500, 0);
  line(0, -500, 0, 500);
  fill(255, 0, 0);
  circle(1, 0, 7);
  popMatrix();
}

void implementAmmoSystem() {
  //reload bar
  pushMatrix();
  stroke(220);
  strokeWeight(1);
  translate(1400, 100);
  //outer bar
  fill(0);
  rect(0, 0, 300, 20);
  //inner bar
  fill(255, 0, 0);
  noStroke();
  if (reloading == 0) { //Shooting Mode
    rect(2, 2, 297, 17);
  }
  if (reloading == 1) { //Reload Mode
    if (reloadTimer < 295) { //Reloading
      rect(2, 2, 297 - reloadTimer*reloadCoefficient, 17);
    }
    if (reloadTimer*reloadCoefficient >= 295) { //Finished reloading
      reloading = 0 ;
      reloadTimer = 0;
      ammo = 0;
    }
  }
  //Ammo indicator
  textSize(40);
  stroke(255);
  strokeWeight(2);
  if (ammo == 4) {
    text("Ammo: RELOAD", 0, -20);
  }
  if (ammo < 4) {
    text("Ammo: " + (4 - ammo) + "/4", 0, -20);
  }
  popMatrix();
  
  if (ammo == 4) {
    reloading = 1;
    reloadTimer = 0;
  }
}

//Improved version of Assignment 1's snowstorm - Now is can be instantiated as an object, cleaner code, and easier to adjust values
void drawSnowstorm() {
  noStroke();
  fill(snowColor);
  for (int i = 0; i < snowstorms.size(); i++) {
    Snowstorm currSnowstorm = snowstorms.get(i);
    currSnowstorm.updateTimer(snowTimer);
    currSnowstorm.drawMe();
  }
}

void drawMenu() {
  pushMatrix();
  background(0);
  translate(width/2, height/2);
  fill(220);
  rect(-300, -200, 600, 100);
  rect(-300, -80, 600, 100);
  fill(255, 0, 0);
  textSize(60);
  //println(mouseX);
  if(mouseX - width/2 > -300 && mouseX - width/2 < 300 && mouseY - height/2 > -200 && mouseY - height/2 < -100) { //Rectangular hit detection
    if (mousePressed) {
      menu = false;
      ammo = 0;
    }
  }
  if(mouseX - width/2 > -300 && mouseX - width/2 < 300 && mouseY - height/2 > -80 && mouseY - height/2 < 20) {
    if (mousePressed) {
      if(crosshair == 0) {
        text("Crosshair: OFF", -210, -10);
        ammo = 0;
      }
      if(crosshair == 1) {
        text("Crosshair: ON", -210, -10);
        ammo = 0;
      }
    }
  }
  
  text("Play", -55, -130);
  if(crosshair == 0) {
    text("Crosshair: OFF", -210, -10);
    ammo = 0;
  }
  if(crosshair == 1) {
    text("Crosshair: ON", -210, -10);
    ammo = 0;
  }
  popMatrix();
}

void drawBackground() {
  background(skyDaytime);
  fill(snowColor);
  noStroke();
  //snow floor
  rect(0, 3*height/8, width, 5*height/8);
}
