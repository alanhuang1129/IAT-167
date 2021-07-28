class BasicEnemy extends Characters {
  int deathTimer;
  
  //Penguin character model variables - Same as previous assignments
  float penguinTimer = 0.0;
  float scaleValue = 1.0;
  int armRotationMode = 0;
  boolean deathLock = false; //if true - penguin is dead
  final float scaleCoefficient = 0.3;
  boolean collectScore = false;
  float movementSpeedBuff = 1.1;
  boolean movementSpeedStun = false;
  int stunTimer = 30;
  boolean hit = false; //To show hp bar upon being hit
  boolean intelligent = false;
  boolean invulnerability = false;
  int invulnerabilityTimer = 120;
  int shieldScale;
  
  BasicEnemy(PVector position, PVector velocity) {
    super(position, velocity);
    health = 6;
    deathTimer = 60;
    alive = true;
    charWidth = 200;
    charHeight = 275;
    shieldScale = 1;
  }
  BasicEnemy(PVector position, PVector velocity, boolean intelligent) {
    super(position, velocity);
    health = 6;
    deathTimer = 60;
    alive = true;
    charWidth = 200;
    charHeight = 275;
    this.intelligent = intelligent;
    shieldScale = 1;
  }
  
  void killed() {
    if (health <= 0) {
      enemies.remove(this);
      //playerScore.incrementScore();
    }
  }
  
  void increaseVelocity(float velocityIncrease) {
    velocity.mult(velocityIncrease);
  }
  
  void moveCharacter() {
    super.moveCharacter();
    if (position.x != 0 && position.y != 0) {
      armRotationMode = 1;
    }
    else {
      armRotationMode = 0;
    }
    penguinTimer++;
  }
  
  void drawEnemy() {
    
     //variables for penguin construction and animation
    color penguinColor = color(0);
    color penguinEyeSockets = color(255);
    color penguinEyePupils = color(0);
    color penguinEyeGlint = color(255);
    color penguinNose = color(255, 165, 0);
    color penguinBelly = color(240);
    color penguinArms = color(0);
    color penguinFeet = color(255, 165, 0);
    color penguinBellyPadding = color(210);
    //final float penguinTimerCoefficient = 0.1; //Change this to change arm movement
    float bobbingSpeed = 2.5;
    float bobbingAmplitude = 1.75;
    final float scaleCoefficient = 0.3; //For this current assignment's scale
    final float hitDetectionCoefficient = 0.70; //For some reason the hitbox doesnt always match up, so this coefficient is used to balance it out - this works for all scales
    
    
    
    pushMatrix(); //Rotation/Scale
    translate(position.x, position.y);
    //Penguin has been pressed and is now dead
    if (mousePressed && dist(mouseX, mouseY, position.x, position.y) < charWidth*scaleValue*scaleCoefficient*hitDetectionCoefficient) {
      //deathLock = true;
    }
    //Hit detection
    if (deathLock == true) {
      armRotationMode = 0;
      rotate(PI/2);
      translate((charWidth/2)*scaleValue*scaleCoefficient, -(charHeight/2)*scaleValue*scaleCoefficient);
    }
    if (armRotationMode == 1) {
      rotate(bobbingAmplitude*radians(sin(penguinTimer*bobbingSpeed)));
    }
    scale(scaleValue*scaleCoefficient); //0.3 for scaleCoefficient on current background
    
    //Penguin Feet
    fill(penguinFeet);
    pushMatrix();
    translate(0, charHeight*1.1 - 172);
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
    ellipse(0, 0, charWidth*1.2, charHeight*1.1);
    popMatrix();
    
    pushMatrix();
    translate(0, -(charHeight/8)); //Rotate around this point
    //Transform Eye Here
    pushMatrix();
    translate(0, -15);
    scale(0.9);
    //End of transformation
    
    //Eye sockets
    pushMatrix();
    fill(penguinEyeSockets);
    circle(-charWidth/4, 0, charWidth/2);
    rotate(radians(180));
    circle(-charWidth/4, 0, charWidth/2);
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
      circle(-(charWidth/4) + 10, 0, (charWidth/4) + 10);
      rotate(radians(180));
      circle((-charWidth/4) + 10, 0, (charWidth/4) + 10);
    }
    popMatrix();
    noStroke();
    
    //Eye Glint
    //Left Glint
    pushMatrix();
    fill(penguinEyeGlint);
    translate(-(charWidth/4) + 10, 0);
    rotate(5*PI/4);
    if (deathLock == false) {
      ellipse(0, 15, 30, 20);
    }
    popMatrix();
    
    //Right Glint
    pushMatrix();
    fill(penguinEyeGlint);
    translate(charWidth/4 - 10, 0);
    rotate(5*PI/4);
    if (deathLock == false) {
      ellipse(0, 15, 30, 20); //It was at this point, I gave up scaling everything by penguin width or height
    }
    popMatrix();
    popMatrix();
    popMatrix();
    
    //Penguin Belly
    fill(penguinBelly);
    arc(0, 0, charWidth*1.2 * 0.85, charHeight*1.1 * 0.85, PI/4, 3*PI/4, CHORD);
    
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
    
      //Penguin Arms
       //Right Arm
       
    fill(penguinArms);
    pushMatrix();
    translate(110, -30);
    float armAmplitude = 0.6; //adjusts magnitude of arm motion
    float timerCoefficient = 0.3; //adjusts speed of arm rotations
    float armRotation = sin(penguinTimer*timerCoefficient)*armAmplitude; //Used sin to simulate back and forth motion
    if (armRotationMode == 1) {
      if (armRotation > 0) {
      rotate(armRotation);
      }
      else {
        rotate(-armRotation);
      }
    }
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
      
    //Penguin Nose
    fill(penguinNose);
    pushMatrix();
    translate(0, -10);
    translate(0, -(charHeight/8));
    translate(0, charWidth/4);
    ellipse(0, 0, charWidth/4, charWidth/6);
    triangle(-charWidth/8, 0, charWidth/8, 0, 0, charHeight/4);
    
    popMatrix();
    popMatrix();
    popMatrix();
    
    //Invulnerability shield
    pushMatrix();
    translate(position.x, position.y);
    scale(shieldScale);
    if (invulnerability) {
      fill(0, 255, 255, 170);
      circle(0, 0, 120);
      noFill();
    }
    popMatrix();
  }
  
  void setVelocity(PVector velocity) {
    this.velocity = velocity;
  }
  
  void movementSpeedStun() {
    if(p1.gunMode == 0) {
      increaseVelocity(0.5); //ironic
    }
    if(p1.gunMode == 1) {
      increaseVelocity(0.9);
    }
    movementSpeedStun = true;
  }
  
  void update() {
    super.update();
    drawEnemy();
    if (health <= 0) {
      if (collectScore == false) {
        playerScore.incrementScore();
        collectScore = true;
        for(int i = 0; i < enemies.size(); i++) {
          BasicEnemy currEnemy = enemies.get(i);
          currEnemy.increaseVelocity(movementSpeedBuff); //difficulty rise on kill
        }
      }
      deathLock = true;
      velocity = new PVector(0, 0);
      deathTimer--;
      if (deathTimer == -1) {
        killed();
      }
    }
    if (movementSpeedStun == true) {
      stunTimer--;
      if (stunTimer == -1) {
        if(p1.gunMode == 0){
          increaseVelocity(2.0); //undo stun (0.5 * 2.0) = 1 -> stun will be permanent if consecutive hits
        }
        if(p1.gunMode == 1) {
          increaseVelocity(1/0.9);
        }
        movementSpeedStun = false;
        stunTimer = 30;
      }
    }
    //Hell spawn penguins
    if (intelligent == true) {
      PVector directionVector = new PVector(p1.position.x - position.x, p1.position.y - position.y);
      directionVector.normalize();
      directionVector.mult(15);
      setVelocity(directionVector);
    }
    //Invulnerability chance
    float invulnerabilityChance = random(0, 100);
    if (invulnerabilityChance < 0.5 && !invulnerability) { //0.5% chance per iteration
      invulnerability = true;
    }
    if(invulnerability == true) {
      invulnerabilityTimer--;
      if(invulnerabilityTimer == -1) {
        invulnerability = false;
        invulnerabilityTimer = 120;
      }
    }
  }
}
