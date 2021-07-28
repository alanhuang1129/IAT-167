class ItemPickup {
  PVector pos, dim;
  int removalTimer = 300;
  boolean pickedUp = false;
  float box;
  
  ItemPickup() {
    dim = new PVector(50, 50);
    pos = new PVector(random(dim.x/2, 1600 - dim.x/2), random(dim.y/2, 1000 - dim.y/2));
    box = random(0, 100); //50% chance to be med box 50% chance to be arms box
  }
  
  void update() {
    drawPickup();
    if(removalTimer == -1) { //if -1, delete this box
      pickupBoxes.remove(this);
    }
    removalTimer--;
    
    if (playerPickup() && box < 50 && pickedUp == false) { //Medbox pickup
      p1.health += 10;
      removalTimer = -1;
      pickedUp = true;
    }
    if (playerPickup() && box >= 50 &&pickedUp == false) { //Arms pickup
      p1.gunMode = 1;
      p1.hasRifle = true;
      removalTimer = -1;
      pickedUp = true;
    }
  }
  
  boolean playerPickup() { //collision detection with player
    float boxLeft = pos.x - dim.x/2;
    float boxRight = pos.x + dim.x/2;
    float boxTop = pos.y - dim.y/2;
    float boxBot = pos.y + dim.y/2;
    
    float playerLeft = p1.position.x - p1.charWidth/2;
    float playerRight = p1.position.x + p1.charWidth/2;
    float playerTop = p1.position.y - p1.charHeight/2;
    float playerBot = p1.position.y + p1.charHeight/2;
    return (boxLeft < playerRight && 
            boxRight > playerLeft &&
            boxTop < playerBot &&
            boxBot > playerTop);
  }
  
  void drawPickup() {
    if (box < 50) {
      //Med Box
      pushMatrix();
      translate(pos.x, pos.y);
      stroke(200);
      strokeWeight(10);
      fill(220);
      rect(-dim.x/2, -dim.y/2, dim.x, dim.y);
      stroke(0, 255, 0);
      strokeWeight(5);
      line(-dim.x/2 + 5, 0, dim.x/2 - 5, 0);
      line(0, -dim.x/2 + 5, 0, dim.x/2 - 5);
      
      noStroke();
      popMatrix();
    }
    else {
      //Arms Box
      pushMatrix();
      translate(pos.x, pos.y);
      stroke(200);
      strokeWeight(10);
      fill(220);
      rect(-dim.x/2, -dim.y/2, dim.x, dim.y);
      stroke(200);
      strokeWeight(5);
      line(-dim.x/2, -dim.y/2, dim.x/2, dim.y/2);
      line(dim.x/2, -dim.y/2, -dim.x/2, dim.y/2);
      
      noStroke();
      popMatrix();
    }
  }
}
