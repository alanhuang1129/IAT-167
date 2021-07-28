class Player extends Characters {
  PVector direction = new PVector(0, 0);
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  PVector bulletVelocity = new PVector(5, 0); // Regular bullet speed is 5
  int gunAmmoCapacity = 10;
  float damp = 0.8;
  int immunityTimer = -1;
  
  //Penguin character model variables - Same as previous assignments
  final float scaleCoefficient = 0.3;
  float penguinTimer = 0.0;
  float scaleValue = 1.0;
  int inverted = 1;
  int armRotationMode = 0;
  boolean deathLock; //if true - penguin is dead
  boolean muzzleFlash = false;
  int gunMode = 0;
  boolean hasRifle = false;
  
  
  Player() {
    super();
    movementSpeed = 1;
  }
  Player(PVector position, PVector velocity) {
    super(position, velocity);
    health = 10;
    charWidth = 200;
    charHeight = 275;
    movementSpeed = 1;
  }
  
  Player(PVector position, PVector velocity, int health, int pWidth, int pHeight) {
    super(position, velocity, health, pWidth, pHeight);
    movementSpeed = 1;
  }
  
  void moveCharacter() {
    super.moveCharacter();
    velocity.mult(damp);
  }
  void accelerate(PVector force) {
    velocity.add(force);
  }
  
  void checkProjectiles(ArrayList<BasicEnemy> enemy) { //Check if projectiles hit enemies, and update projectile
    for (int i = 0; i < projectiles.size(); i++) {
      Projectile currProjectile = projectiles.get(i);
      currProjectile.update();
      //if(!currProjectile.isAlive) projectiles.remove(currProjectile);
      for (int j = 0; j < enemy.size(); j++) {
        BasicEnemy currEnemy = enemy.get(j);
        if (!currEnemy.invulnerability) {
          currProjectile.hit(currEnemy);
          currEnemy.hit = true;
          if (currEnemy.health <= 0) {
            currEnemy.alive = false;
          }
        }
        //currEnemy.killed(); //if health <= 0, remove this enemy
      }
     
    }
  }
  
  void update() {
    super.update();
    if(immunityTimer == -1) { //Regular draw -> not hit
      drawPlayer();
    }
    checkProjectiles(enemies);
    penguinTimer = timer;
    for (int i = 0; i < enemies.size(); i++) {
      BasicEnemy currEnemy = enemies.get(i);
      if (hitCharacter(currEnemy) && immunityTimer == -1 && currEnemy.alive == true) {
        decreaseHealth(3);
        immunityTimer = 60;
      }
    }
    if (immunityTimer >= 0)  {
      immunityTimer--;
      if(immunityTimer % 30 >= 15) { //player hit animation (blinking)
        drawPlayer();
      }
    }
    displayHealth();
  }
  
  void displayHealth() {
    pushMatrix();
    textAlign(CENTER);
    translate(100, 100);
    fill(255, 0, 0);
    text("Health: " + health, 0, 0);
    popMatrix();
  }
  
  void fireProjectile () {
    PVector directionVector = new PVector(mouseX - position.x, mouseY - position.y); //direction vector of the projectile to the mouse (not normalized)
    //Getting the angle of the line rotation (for draw method)
    PVector positiveX = new PVector(1, 0); //positive x-axis
    PVector negativeX = new PVector(-1, 0);
    float angle = 0;
    //angle is split between two cases, because angleBetween gives the reference angle and will not return a negative angle
    if (mouseY < position.y) {
      angle = PVector.angleBetween(negativeX, directionVector);
    }
    if (mouseY >= position.y) {
      angle = PVector.angleBetween(positiveX, directionVector);
    }
    
    //Getting the proper direction vector
    directionVector.normalize();
    float bulletVelocityScalar = bulletVelocity.mag(); //Magnitude of the bullet velocity (5 is default)
    directionVector.mult(bulletVelocityScalar); //Multiple the speed to the direction vector
    
    //Give the projectile the proper angle and direction
    projectiles.add(new Projectile(new PVector(position.x, position.y), new PVector(10, 0), angle, directionVector));
  }
  
  
  
  
  
  void movingAnimation(int setMode) {
    armRotationMode = setMode;
  }
  
  void setInversion(int inversion) {
    inverted = inversion;
  }
  
  void setMuzzleFlash(boolean flash) {
    muzzleFlash = flash;
  }
  
  void drawPlayer() {
    
    color penguinColor = color(0);
    color penguinEyeSockets = color(255);
    color penguinEyePupils = color(0);
    color penguinEyeGlint = color(255);
    color penguinNose = color(255, 165, 0);
    color penguinBelly = color(240);
    color penguinArms = color(0);
    color penguinFeet = color(255, 165, 0);
    color penguinBellyPadding = color(210);
    final int penguinBodyWidth = 200;
    final int penguinBodyHeight = 275;
    //final float penguinTimerCoefficient = 0.1; //Change this to change arm movement
    float bobbingSpeed = 1;
    float bobbingAmplitude = 3;
    final float hitDetectionCoefficient = 0.70; //For some reason the hitbox doesnt always match up, so this coefficient is used to balance it out - this works for all scales
    
    pushMatrix(); //Rotation/Scale
    translate(position.x, position.y);
    //Penguin has been pressed and is now dead
    if (mousePressed && dist(mouseX, mouseY, position.x, position.y) < penguinBodyWidth*scaleValue*scaleCoefficient*hitDetectionCoefficient) {
      //deathLock = true;
    }
    //Hit detection
    if (deathLock == true) {
      armRotationMode = 0;
      rotate(PI/2);
      translate((penguinBodyWidth/2)*scaleValue*scaleCoefficient, -(penguinBodyHeight/2)*scaleValue*scaleCoefficient);
    }
    if (armRotationMode == 1) {
      rotate(bobbingAmplitude*radians(sin(penguinTimer*bobbingSpeed)));
    }
    scale(inverted, 1); //used to flip image
    scale(scaleValue*scaleCoefficient); //0.3 for scaleCoefficient on current background

    
    //Penguin Feet
    fill(penguinFeet);
    pushMatrix();
    translate(0, penguinBodyHeight*1.1 - 172);
       //Right Feet
    arc(48, 20, 125, 50, PI, 2*PI);  
       //Left Feet
    arc(-48, 20, 125, 50, PI, 2*PI);
    popMatrix();
    
    //Penguin Body
    pushMatrix();
    noStroke();
    fill(penguinColor);
    pushMatrix();
    ellipse(0, 0, penguinBodyWidth*1.2, penguinBodyHeight*1.1);
    popMatrix();
    
    pushMatrix();
    translate(0, -(penguinBodyHeight/8)); //Rotate around this point
    //Transform Eye Here
    pushMatrix();
    translate(0, -15);
    scale(0.9);
    //End of transformation
    
    //Eye sockets
    pushMatrix();
    fill(penguinEyeSockets);
    circle(-penguinBodyWidth/4, 0, penguinBodyWidth/2);
    rotate(radians(180));
    circle(-penguinBodyWidth/4, 0, penguinBodyWidth/2);
    popMatrix();
    
    //Eyes
    pushMatrix();
    fill(penguinEyePupils);
    if (deathLock == true) {
      strokeWeight(20);
      stroke(penguinEyePupils);
      line(-70, 20, -20, -20);
      line(-70, -20, -20, 20);
      
      line(70, 20, 20, -20);
      line(70, -20, 20, 20);
      
    }
    else {
      circle(-(penguinBodyWidth/4) + 10, 0, (penguinBodyWidth/4) + 10);
      rotate(radians(180));
      circle((-penguinBodyWidth/4) + 10, 0, (penguinBodyWidth/4) + 10);
    }
    popMatrix();
    noStroke();
    
    //Eye Glint
    //Left Glint
    pushMatrix();
    fill(penguinEyeGlint);
    translate(-(penguinBodyWidth/4) + 10, 0);
    rotate(5*PI/4);
    if (deathLock == false) {
      ellipse(0, 15, 30, 20);
    }
    popMatrix();
    
    //Right Glint
    pushMatrix();
    fill(penguinEyeGlint);
    translate(penguinBodyWidth/4 - 10, 0);
    rotate(5*PI/4);
    if (deathLock == false) {
      ellipse(0, 15, 30, 20); //It was at this point, I gave up scaling everything by penguin width or height
    }
    popMatrix();
    popMatrix();
    popMatrix();
    
    //Penguin Belly
    fill(penguinBelly);
    arc(0, 0, penguinBodyWidth*1.2 * 0.85, penguinBodyHeight*1.1 * 0.85, PI/4, 3*PI/4, CHORD);
    
    pushMatrix();
    translate(0, 92);
    arc(0, 0, 144, 130, PI, 2*PI, OPEN);
    
    //Belly Padding
    fill(penguinBellyPadding);
    triangle(-10, 0, 10, 0, 0, 20);
    translate(-20, -10);
    triangle(-10, 0, 10, 0, 0, 20);
    translate(40, 0);
    triangle(-10, 0, 10, 0, 0, 20);
    translate(-60, 10);
    triangle(-10, 0, 10, 0, 0, 20);
    translate(80, 0);
    triangle(-10, 0, 10, 0, 0, 20);
    translate(-20, 15);
    triangle(-10, 0, 10, 0, 0, 20);
    translate(-40, 0);
    triangle(-10, 0, 10, 0, 0, 20);
    
    popMatrix();
    
    //Penguin Nose
    fill(penguinNose);
    pushMatrix();
    translate(0, -10);
    translate(0, -(penguinBodyHeight/8));
    translate(0, penguinBodyWidth/4);
    ellipse(0, 0, penguinBodyWidth/4, penguinBodyWidth/6);
    triangle(-penguinBodyWidth/8, 0, penguinBodyWidth/8, 0, 0, penguinBodyHeight/4);
    
    popMatrix();
    
      //Penguin Arms
       //Right Arm
       
    fill(penguinArms);
    pushMatrix();
    translate(70, 10);
    float armAmplitude = 0.6; //adjusts magnitude of arm motion
    float timerCoefficient = 0.3; //adjusts speed of arm rotations
    //float armRotation = sin(penguinTimer*timerCoefficient)*armAmplitude; //Used sin to simulate back and forth motion
    
    //Reused angle finding code - with some adjustments
    PVector directionVector = new PVector(mouseX - position.x, mouseY - position.y); //direction vector of the projectile to the mouse (not normalized)
    //Getting the angle of the line rotation (for draw method)
    PVector positiveX = new PVector(1, 0); //positive x-axis
    PVector negativeX = new PVector(-1, 0);
    float angle = 0;
    //angle is split between two cases, because angleBetween gives the reference angle and will not return a negative angle
    if (mouseY < position.y) {
      angle = PVector.angleBetween(negativeX, directionVector) + radians(180);
    }
    if (mouseY >= position.y) {
      angle = PVector.angleBetween(positiveX, directionVector);
    }
    rotate(inverted*(angle - radians(90)));

    //Lift arms if hit
    if (deathLock == true) {
      rotate(PI);
    }
  
    arc(0, 70, 60, 140, 0, 2*PI);
    popMatrix();
    
       //Left Arm
    fill(penguinArms);
    pushMatrix();
    translate(-110, -30);
    float armOffset = PI/2;
    float armRotation2 = sin(penguinTimer*timerCoefficient - armOffset)*armAmplitude;
    if (armRotationMode == 1) {
      if (armRotation2 > 0) {
      rotate(-armRotation2);
      }
      else {
        rotate(armRotation2);
      }
    }
    if (deathLock == true) {
      rotate(-PI/4);
    }
    arc(0, 70, 60, 140, 0, 2*PI);
    popMatrix();
    
    popMatrix();
    
    //Headband
    fill(255, 0, 0);
    rect(-85, -130, 170, 30, 1000, 1000, 0, 0);
    
    //War Paint
    strokeWeight(10);
    stroke(80, 60, 10);
    line(60, 0, 90, 10);
    stroke(101, 67, 33);
    line(55, 15, 90, 35);
    stroke(120, 60, 40);
    line(50, 30, 80, 50);
    
    pushMatrix();
    scale(-1, 1);
    stroke(80, 60, 10);
    line(60, 0, 90, 10);
    stroke(101, 67, 33);
    line(55, 15, 90, 35);
    stroke(120, 60, 40);
    line(50, 30, 80, 50);
    popMatrix();
    
    
    
    stroke(240);
    strokeWeight(3);
    //Pistol
    pushMatrix();
    translate(70, 10);
    rotate(inverted*(angle));
    if(inverted == 1 && angle <= radians(270) && angle >= radians(90)) {
      scale(1, -1);
    }
    if(inverted == -1 && !(angle <= radians(270) && angle >= radians(90))) {
      scale(1, -1);
    }
    scale(inverted, inverted);
    pushMatrix();
    
    if(gunMode == 0) { //Pistol
      //Handle
      fill(181, 101, 29);
      translate(0, 10);
      pushMatrix();
      rotate(radians(10));
      
      rect(100, -85, 30, 80, 7);
      
      popMatrix();
      
      //Barrel
      fill(220);
      rect(90, -70, 110, 30, 3, 6, 20, 10);
    
    
      //Muzzle Flash
      if (muzzleFlash == true) {
        fill(255, 255, 0);
          //Top flash
        triangle(200, -75, 240, -120, 220, -70);
          //Bottom flash
        pushMatrix();
        scale(1, -1);
        translate(0, 120);
        triangle(200, -75, 240, -120, 220, -70);
        
          //Middle flash
        triangle(200, -75, 280, -60, 200, -45);
        popMatrix();
      }
    }
    
    if(gunMode == 1) { //Assault Rifle
      //Handle
      fill(0);
      noStroke();
      translate(0, 10);
      pushMatrix();
      rotate(radians(10));
      
      rect(100, -85, 30, 80, 7);
      
      popMatrix();
      
      //Magazine
      pushMatrix();
      rotate(radians(10));
      //rect(170, -85, 40, 120, 7);
      scale(1, -1);
      quad(160, 80, 160, -10, 210, -10, 210, 80);
      popMatrix();
      
      //Barrel
      fill(20);
      rect(90, -70, 270, 30, 3, 6, 20, 10);
      
      fill(0);
      rect(240, -75, 70, 40, 0, 10, 10, 0);
      
      //Middle Area
      fill(20);
      rect(115, -70, 105, 50);
      
      //Stock
      fill(0);
      triangle(130, -70, 50, -70, 50, -10);
      
      //Muzzle Flash
      if (muzzleFlash == true) {
        pushMatrix();
        translate(150, 0);
        fill(255, 255, 0);
          //Top flash
        triangle(200, -75, 240, -120, 220, -70);
          //Bottom flash
        pushMatrix();
        scale(1, -1);
        translate(0, 120);
        triangle(200, -75, 240, -120, 220, -70);
        
          //Middle flash
        triangle(200, -75, 280, -60, 200, -45);
        popMatrix();
        popMatrix();
    }
    }
    
    
    
    
    
    
    popMatrix();
    popMatrix();   
    popMatrix();
    
    strokeWeight(1);
    stroke(0);
    
    }
    

}
