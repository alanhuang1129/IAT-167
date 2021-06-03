//-PLEASE READ- 
//Interactions -> Left mouse click to stop the moving penguins, click again to resume movement (can't resume movement of following penguin for some reason)
//             -> Hold left click to restart scenario
//             -> Move around the cursor to make the following penguin follow the cursor
//There are some animations that take time to show up (Last timed animation is when the pop up penguin pops back down, there are no other animation other than the ongoing animations)
//8 Characters - 4 Hiding penguins, 1 pop up penguin, 1 following penguin, 1 pop up penguin, 1 regular penguin
//2 Mouse interactions - 1. Click to stop pop up penguin's movement (following penguin as well)
//                     - 2. Following Penguin follows the cursor


//Part 1 (Background) Global Variables
//Fills
color treeBark = color(149, 85, 0);
color pineGreen = color(22, 96, 55);
color snowColor = color(255);
color cloudEyeGlint = color(248);
color sunRay = color(255, 255, 0);
color cloudShade = color(240);
color cloudEyes = color(0);
color skiColor = color(255, 0, 0);
//Strokes
color cloudSmile = color(0);
color skiDesignColor = color(255, 255, 0);
color treeBarkOutline = treeBark/2;
color pineGreenOutline = pineGreen/2;


//Variables for animation
boolean sunRayDirection = true; //true = shrink sun rays, false = enlarge sun ray
float sunRayFlare = 1.0; //Must range from 0.75 to 1.0 (possible to be more than 1)
float snowFall1 = 0.0;
float snowFall2 = 0.0;
float snowFall3 = 0.0;
float snowFall4 = 0.0;
float snowFallSpeed = 10.0;

int timeInterval = 50;
int[] rand1 = new int[8];
int[] randSpeed1 = new int[8];
int[] rand2 = new int[8];
int[] randSpeed2 = new int[8];
int[] rand3 = new int[8];
int[] randSpeed3 = new int[8];
int[] rand4 = new int[8];
int[] randSpeed4 = new int[8];

int delay = 5;

//Part 2 (Character) Global Variables
//Color Variables + penguin dimensions
color penguinColor = color(0);
color penguinEyeSockets = color(255);
color penguinEyePupils = color(0);
color penguinEyeGlint = color(255);
color penguinNose = color(255, 165, 0);
color penguinBelly = color(240);
color penguinArms = color(0);
color penguinFeet = color(255, 165, 0);
color penguinBellyPadding = color(210);
int penguinBodyWidth = 200;
int penguinBodyHeight = 275;
//Animation Values
int rotationValue;
float scaleValue;

//Part 3 Animation Variables
float timer = 0.0;
//Restart - hold left mouse button
float restartScene = 0.0;
//penguin movement
int rotationMode = 1;
float tempTimer = timer;
int timerMode = 1; //1 = unpaused, 0 = paused
//pop up penguin
float popUpDelay = 0.0;
float popUpTimer = 0.0;
float popDownDelay = 0.0;
float popDownTimer = 0.0;
//following penguin
int currentPosition = 220;
//snowman penguin
int alpha1 = 0;
int alpha2 = 0;
int alpha3 = 0;

void setup() {
  size(600, 600);
}

void draw() {
  //Scene Restart
  if (mousePressed) {
    restartScene += 0.1;
    if (restartScene > 8.0) {
      timer = 0.0;
      popUpDelay = 0.0;
      popUpTimer = 0.0;
      popDownDelay = 0.0;
      popDownTimer = 0.0;
      tempTimer = timer;
      timerMode = 1;
      rotationMode = 1;
      currentPosition = 220;
      restartScene = 0.0;
    }
  }
  //BackgroundColor - I needed to separate this from drawBackground to make the penguin behind the tree visible
  background(0, 255, 255); 
  drawCharacter(120, 420, 0.20, radians(30), 0);
  drawCharacter(220, 420, 0.20, radians(30), 0);
  drawCharacter(180, 420, 0.20, radians(-30), 0);
  drawCharacter(280, 420, 0.20, radians(-30), 0);
  drawBackground();
  drawCharacter(350, 450, 0.26, 0, 0);
  drawCharacter(450, 480, 0.30, 0, 0);
  
  //Snowman penguin
  alpha1 = (int)((timer - 30) * 16);
  alpha2 = (int)((timer - 60) * 16);
  alpha3 = (int)((timer - 120) * 16);
  if (timer > 30.0) {
    //First set
    fill(255, alpha1);
    circle(350, 420, 10);
    circle(345, 415, 10);
    circle(355, 415, 10);
    circle(365, 420, 10);
    circle(335, 420, 10);
    circle(360, 415, 10);
  }
  if (timer > 60.0) {
    //Second set
    fill(255, alpha2);
    circle(332, 424, 10);
    circle(338, 420, 10);
    circle(350, 415, 10);
    circle(325, 440, 10);
    circle(320, 445, 10);
    circle(325, 435, 10);
    circle(380, 440, 10);
    circle(375, 450, 10);
    circle(380, 445, 10);
  
    circle(340, 480, 20);
    circle(335, 485, 20);
    circle(350, 480, 20);
    circle(345, 485, 20);
    circle(370, 480, 20);
    circle(320, 470, 20);
  }
  if (timer > 120.0) {
    //Third set
    fill(255, alpha3);
    circle(350, 480, 100);
    circle(350, 430, 75);
    circle(350, 385, 50);
    fill(0, alpha3);
    circle(340, 380, 5);
    circle(360, 380, 5);
    circle(350, 412, 5);
    circle(350, 425, 5);
    circle(350, 438, 5);
  }

  
  //following penguin
  float bobbingSpeed2 = 2.5;
  float bobbingAmplitude2 = 1.75;
  if (mouseX > currentPosition && mouseX <= 548 && timerMode == 1) {
    currentPosition += 1;

    drawCharacter(currentPosition, 520, 0.37, bobbingAmplitude2*radians(sin(timer*bobbingSpeed2)), 1);
    
    println(mouseX);
  }
  else if (mouseX < currentPosition && timerMode == 1) {
    currentPosition -= 1;
    drawCharacter(currentPosition, 520, 0.37, bobbingAmplitude2*radians(sin(timer*bobbingSpeed2)), 1);
  }
  else {
    drawCharacter(currentPosition, 520, 0.37, 0, 0);
  }
  
  //Penguin1  - AKA pop up penguin, translation, rotation, and scale
  if((int)(timer * 3) < 300) {
    float scaleCoefficient = 0.004;
    if (timerMode%2 == 0) { //Paused time
      timer = tempTimer; //Pause timer
      drawCharacter(100, 420 + (int)(tempTimer * 3), 0.25 + scaleCoefficient*timer, 0, rotationMode%2);
    }
    float bobbingSpeed = 2.5;
    float bobbingAmplitude = 1.75;
    if (timerMode%2 == 1) { //Continued time
      drawCharacter(100, 420 + (int)(timer * 3), 0.25 + scaleCoefficient*timer, bobbingAmplitude*radians(sin(timer*bobbingSpeed)), rotationMode%2);
    }
  }
  else {
    int popUpTimerCoefficient = 10;
    popUpDelay += 0.1;
    //println(popUpDelay);
    if (popUpDelay > 5.0) { //Delay until penguin1 pops up
      if ((int)(popUpTimer * popUpTimerCoefficient) < 310) { //Slowly pops up
        drawCharacter(100, 910 - (int)(popUpTimer * popUpTimerCoefficient), 2.0, 0, 0);
      }
      if ((int)(popUpTimer * popUpTimerCoefficient) > 310) { //After popping up, stay in position at (100, 600)
        if (popDownDelay <= 15.0) {
          drawCharacter(100, 600, 2.0, 0, 0);
        }
        popDownDelay += 0.1;
        //println(popDownDelay);
        if (popDownDelay > 15.0) { //penguin1 pops back down
          if ((int)(popDownTimer * popUpTimerCoefficient) < 310) {
            drawCharacter(100, 600 + (int)(popDownTimer * popUpTimerCoefficient), 2.0, 0, 0);
          }
          popDownTimer += 0.1;
        }
      }
      popUpTimer += 0.1;
    }
  }

  timer += 0.1;
}



void mousePressed() {
  rotationMode++;
  timerMode++; 
  tempTimer = timer;
}
void mouseReleased() {
  restartScene = 0.0;
}

//I will be adding another parameter to give the penguin more life - armRotationMode -> 0 = not rotating, 1 = rotating (for walking motion)
void drawCharacter(int x, int y, float scale, float rotation, int armRotationMode){
  pushMatrix(); //Rotation/Scale
  //translate(width/2, height/2);
  translate(x, y);
  //rotationValue = mouseX*360/(height - 1); // scales up to 360 rather than 399
  //rotate(PI/4 - radians(rotationValue)/4);
  rotate(rotation);
  //scaleValue = (mouseY*1.5/(height - 1)) + 0.5; //scales from 0.5 to 2.0
  scale(scale);
  
  //Penguin Feet
  fill(penguinFeet);
  pushMatrix();
  translate(0, penguinBodyHeight*1.1 + 28 - 200);
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
  circle(-(penguinBodyWidth/4) + 10, 0, (penguinBodyWidth/4) + 10);
  rotate(radians(180));
  circle((-penguinBodyWidth/4) + 10, 0, (penguinBodyWidth/4) + 10);
  popMatrix();
  
  //Eye Glint
  //Left Glint
  pushMatrix();
  fill(penguinEyeGlint);
  translate(-(penguinBodyWidth/4) + 10, 0);
  rotate(5*PI/4);
  ellipse(0, 15, 30, 20); //It was at this point, I gave up scaling everything by penguin width or height
  popMatrix();
  
  //Right Glint
  pushMatrix();
  fill(penguinEyeGlint);
  translate(penguinBodyWidth/4 - 10, 0);
  rotate(5*PI/4);
  ellipse(0, 15, 30, 20); //It was at this point, I gave up scaling everything by penguin width or height
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
  float armRotation = sin(timer*timerCoefficient)*armAmplitude; //Used sin to simulate back and forth motion
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
  float armRotation2 = sin(timer*timerCoefficient - armOffset)*armAmplitude;
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



void drawBackground() {
  //Background
  //background(0, 255, 255); 
  
  //Snow flooring
  noStroke();
  fill(snowColor);
  rect(0, 450, 600, 450, 0, 200, 600, 600);
  
  //Pine trees
      //Trunk
  fill(treeBark);
  stroke(treeBarkOutline);
  rect(85, 240, 30, 210);
      //Leaves
  fill(pineGreen);
  stroke(pineGreenOutline);
  triangle(100, 170, 60, 240, 140, 240);
  triangle(100, 130, 60, 200, 140, 200);
  triangle(100, 90, 60, 160, 140, 160);
  triangle(100, 50, 60, 120, 140, 120);
  
    //Pine trees 2
      //Trunk
  fill(treeBark);
  stroke(treeBarkOutline);
  pushMatrix();
  translate(100, 0);
  rect(85, 240, 30, 210);
      //Leaves
  fill(pineGreen);
  stroke(pineGreenOutline);
  triangle(100, 170, 60, 240, 140, 240);
  triangle(100, 130, 60, 200, 140, 200);
  triangle(100, 90, 60, 160, 140, 160);
  triangle(100, 50, 60, 120, 140, 120);
  popMatrix();
  
    //Pine trees 3
      //Trunk
  fill(treeBark);
  stroke(treeBarkOutline);
  pushMatrix();
  translate(200, 0);
  rect(85, 240, 30, 210);
      //Leaves
  fill(pineGreen);
  stroke(pineGreenOutline);
  triangle(100, 170, 60, 240, 140, 240);
  triangle(100, 130, 60, 200, 140, 200);
  triangle(100, 90, 60, 160, 140, 160);
  triangle(100, 50, 60, 120, 140, 120);
  popMatrix();
  
  //Sun
  noStroke();
  fill(sunRay);
  arc(550, 50, 100, 100, 0,2*PI);
  
  //Sun rays
  stroke(sunRay);
  strokeWeight(8);
  pushMatrix();
  translate(550, 50);
  rotate(6.5);
  //Sun ray animation
  if (sunRayDirection == true) {
    if (sunRayFlare < 0.75) {
      sunRayDirection = false;
    }
    sunRayFlare -= 0.01;
  }
  if (sunRayDirection == false) {
    if (sunRayFlare > 1.0) {
      sunRayDirection = true;
    }
    sunRayFlare += 0.01;
  }
  //End of animation code
  line(-100*sunRayFlare, 0, -75, 0);
  rotate(-0.66);
  line(-100*sunRayFlare , 0, -75, 0);
  rotate(-0.66);
  line(-100*sunRayFlare, 0, -75, 0);
  rotate(-0.66);
  line(-100*sunRayFlare, 0, -75, 0);
  popMatrix();
  
  //Cloud
  noStroke();
  fill(cloudShade);
  pushMatrix();
  translate(350, 50);
  ellipse(-20, 0, 110, 45);
  ellipse(20, 0, 110, 45);
  rotate(9);
  ellipse(0, 0, 110, 45);
  rotate(-18);
  ellipse(0, 0, 110, 45);
  popMatrix();
  
  //Cloud eyes
  fill(cloudEyes);
  pushMatrix();
  translate(350, 40);
  arc(-20, 0, 10, 10, 0, 2*PI);
  arc(20, 0, 10, 10, 0, 2*PI);
  //eye glint
  fill(cloudEyeGlint);
  pushMatrix(); //Left Eye - your left
  translate(-20, 0);
  rotate(-mouseX/120);
  arc(2, -2, 5, 5, 0, 2*PI);
  popMatrix();
  
  pushMatrix(); //Right Eye
  translate(20, 0);
  rotate(-mouseX/120);
  arc(2, -2, 5, 5, 0, 2*PI);
  
  popMatrix();
  //cloud smile
  stroke(cloudSmile);
  strokeWeight(2);
  curve(-15, 20, -5, 25, 5, 25, 15, 20);
  popMatrix();
  
  
  //Skiis
  noStroke();
  fill(skiColor);
  pushMatrix();
  quad(40, 450, 40, 380, 50, 382, 50, 450);
  translate(-15, 0);
  quad(40, 450, 40, 380, 50, 382, 50, 450);
  popMatrix();
  
  //Skii design
  stroke(skiDesignColor);
  strokeWeight(1);
  pushMatrix();
  curve(43, 380, 47, 397, 43, 415, 47, 432);
  translate(0, 10);
  curve(43, 380, 47, 397, 43, 415, 47, 432);
  translate(-15, -10);
  curve(43, 380, 47, 397, 43, 415, 47, 432);
  translate(0, 10);
  curve(43, 380, 47, 397, 43, 415, 47, 432);
  popMatrix();
  
  //Snow storm (Animated) - If only I could use custom methods
  noStroke();
  fill(snowColor);
  //First Set of snow
  if (snowFall1%timeInterval == 0) {//As snowFall reaches timeInterval -> reset snowfall with random values
    for (int i = 0; i < 8; i++) {
      rand1[i] = (int)random(100, 600); //cast random value to int and store into rand[i] - These random values are start points along the x-axis
      randSpeed1[i] = (int)random(80, 120); // These random values dictate the different speeds, example: 80 = 80% speed
    }
    snowFall1 = 0;
  }
  for (int j = 0; j < 8; j++) { //Production of snow
    circle(rand1[j] - snowFall1, snowFall1 * randSpeed1[j]*0.01*snowFallSpeed, 10);
  }
  
  //Second Set of snow
   if (snowFall2%(timeInterval+delay) == 0) {
    for (int i = 0; i < 8; i++) {
      rand2[i] = (int)random(100, 600); //cast random value to int and store into rand[i]
      randSpeed2[i] = (int)random(80, 120);
    }
    snowFall2 = 0;
  }
  for (int j = 0; j < 8; j++) {
    circle(rand2[j] - snowFall2, snowFall2 * randSpeed2[j]*0.01*snowFallSpeed, 10);
  }
  
  //Third Set of snow
   if (snowFall3%(timeInterval+(2*delay)) == 0) {
    for (int i = 0; i < 8; i++) {
      rand3[i] = (int)random(100, 600); //cast random value to int and store into rand[i]
      randSpeed3[i] = (int)random(80, 120);
    }
    snowFall3 = 0;
  }
  for (int j = 0; j < 8; j++) {
    circle(rand3[j] - snowFall3, snowFall3 * randSpeed3[j]*0.01*snowFallSpeed, 10);
  }
  
  //Fourth Set of snow
   if (snowFall4%(timeInterval+(3*delay)) == 0) {
    for (int i = 0; i < 8; i++) {
      rand4[i] = (int)random(100, 600); //cast random value to int and store into rand[i]
      randSpeed4[i] = (int)random(80, 120);
    }
    snowFall4 = 0;
  }
  for (int j = 0; j < 8; j++) {
    circle(rand4[j] - snowFall4, snowFall4 * randSpeed4[j]*0.01*snowFallSpeed, 10);
  }
  
  
  //println(snowFall1);
  snowFall1 += 1;
  snowFall2 += 1;
  snowFall3 += 1;
  snowFall4 += 1;
}
