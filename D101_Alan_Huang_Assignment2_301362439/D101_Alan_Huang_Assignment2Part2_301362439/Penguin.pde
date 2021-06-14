class Penguin {
  //fields
  int xPos;
  int yPos;
  int xSpeed;
  int ySpeed;
  float scaleValue;
  int armRotationMode;
  float penguinTimer = 0.0;
  boolean xSpeedOn; //These variables are to tell us if the penguin is moving
  boolean ySpeedOn;

  
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
  final int penguinBodyWidth = 200;
  final int penguinBodyHeight = 275;
  final float penguinTimerCoefficient = 0.1; //Change this to change arm movement
  float bobbingSpeed = 2.5;
  float bobbingAmplitude = 1.75;
  final float scaleCoefficient = 0.3; //For this current assignment's scale
  
  //Constructors
  Penguin() {
    xPos = width/2;
    yPos = height/2;
    xSpeed = (int)random(1,8);
    ySpeed = (int)random(1,8);
    scaleValue = 1.0;
    armRotationMode = 0;
    xSpeedOn = false;
    ySpeedOn = false;

  }
  Penguin(int xPos, int yPos, float scale) { //For creation of stationary penguins if wanted
    this.xPos = xPos;
    this.yPos = yPos;
    xSpeed = (int)random(1,8);
    ySpeed = (int)random(1,8);
    scaleValue = scale;
    armRotationMode = 0;
    xSpeedOn = false;
    ySpeedOn = false;

  }
  Penguin(int xPos, int yPos, int xSpeed, int ySpeed, float scale) { //Regular instantiation
    this.xPos = xPos;
    this.yPos = yPos;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    scaleValue = scale;
    armRotationMode = 0;
    xSpeedOn = false;
    ySpeedOn = false;

  }
  
  //Methods
  void detectWall() {
    if (xPos > width + 100) {
      xPos = -100;
    }
    if (xPos < -100) {
      xPos = width + 100;
    }
    if (yPos < -100) {
      yPos = height + 150;
    }
    if (yPos > height + 150) {
      yPos = -100;
    }
  }
  void move() { //This is just for part 
    detectWall();
    xPos += xSpeed;
    yPos += ySpeed;
    xSpeedOn = true;
    ySpeedOn = true;
    armRotationMode = 1;
  }
  void moveRight() {
    detectWall();
    xPos += xSpeed;
    xSpeedOn = true;
    armRotationMode = 1;
  }
  void moveLeft() {
    detectWall();
    xPos -= xSpeed;
    xSpeedOn = true;
    armRotationMode = 1;
  }
  void moveDown() {
    detectWall();
    yPos += ySpeed;
    ySpeedOn = true;
    armRotationMode = 1;
  }
  void moveUp() {
    detectWall();
    yPos -= ySpeed;
    ySpeedOn = true;
    armRotationMode = 1;
  }
  void changeXSpeed(int xSpeed) {
    this.xSpeed = xSpeed;
  }
  void changeYSpeed(int ySpeed) {
    this.ySpeed = ySpeed;
  }
  void changeArmRotationMode() {
    armRotationMode++;
    armRotationMode %= 2;
  }


  
  void updateTimer(float timer) {
    //speedCase for arm rotation intensity according to movement
    int speedCase = 0;
    float speedCoefficient = 1.0;
    if (!xSpeedOn && !ySpeedOn) {
      speedCase = 0;
    }
    if (xSpeedOn == true && ySpeedOn == false) {
      speedCase = 1;
    }
    if (xSpeedOn == false && ySpeedOn == true) {
      speedCase = 2;
    }
    if (xSpeedOn && ySpeedOn) {
      speedCase = 3;
    }
    switch(speedCase) {
      case 0: 
        speedCoefficient = 1.0;
        break;
      case 1: 
        speedCoefficient = xSpeed;
        break;
      case 2: 
        speedCoefficient = ySpeed;
        break;
      case 3: 
        speedCoefficient = sqrt(xSpeed^2 + ySpeed^2);
        break;
      default:
        break;
    }
    penguinTimer = timer*penguinTimerCoefficient*speedCoefficient;
  }
  
  void drawMe() {
  pushMatrix(); //Rotation/Scale
  translate(xPos, yPos);
  if (armRotationMode == 1) {
    rotate(bobbingAmplitude*radians(sin(penguinTimer*bobbingSpeed)));
  }
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
  fill(penguinEyePupils);
  pushMatrix();
  circle(-(penguinBodyWidth/4) + 10, 0, (penguinBodyWidth/4) + 10);
  rotate(radians(180));
  circle((-penguinBodyWidth/4) + 10, 0, (penguinBodyWidth/4) + 10);
  popMatrix();
  noStroke();
  
  //Eye Glint
  //Left Glint
  pushMatrix();
  fill(penguinEyeGlint);
  translate(-(penguinBodyWidth/4) + 10, 0);
  rotate(5*PI/4);
  ellipse(0, 15, 30, 20);
  popMatrix();
  
  //Right Glint
  pushMatrix();
  fill(penguinEyeGlint);
  translate(penguinBodyWidth/4 - 10, 0);
  rotate(5*PI/4);
  ellipse(0, 15, 30, 20);
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
  
    //Penguin Arms
     //Right Arm
     
  fill(penguinArms);
  pushMatrix();
  translate(110, -30);
  float armAmplitude = 0.6; //adjusts magnitude of arm motion
  float timerCoefficient = 0.95; //adjusts speed of arm rotations
  float armRotation = sin(penguinTimer*timerCoefficient)*armAmplitude; //Used sin to simulate back and forth motion
  if (armRotationMode == 1) {
    if (armRotation > 0) {
    rotate(armRotation);
    }
    else {
      rotate(-armRotation);
    }
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
  arc(0, 70, 60, 140, 0, 2*PI);
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
  popMatrix();
  popMatrix();
  }
}
