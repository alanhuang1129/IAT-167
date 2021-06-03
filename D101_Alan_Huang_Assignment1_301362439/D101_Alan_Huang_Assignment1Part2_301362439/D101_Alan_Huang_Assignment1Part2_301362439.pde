//Reference used - https://www.how-to-draw-funny-cartoons.com/draw-a-penguin.html
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
//Arc, Ellipse, Circle, Triangle

void setup() {
  size (400, 400);
}

void draw() {
  //background
  background(0, 255, 255);
  
  pushMatrix(); //Rotation/Scale
  translate(width/2, height/2);
  rotationValue = mouseX*360/(height - 1); // scales up to 360 rather than 399
  rotate(PI/4 - radians(rotationValue)/4);
  
  scaleValue = (mouseY*1.5/(height - 1)) + 0.5; //scales from 0.5 to 2.0
  scale(scaleValue);
  
  //Penguin Feet
  fill(penguinFeet);
  pushMatrix();
  translate(0, penguinBodyHeight*1.1 + 28 - height/2);
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
  //rotate(radians(mouseX*360/399)/6); --> arm rotation code (plan to use for part 3)
  arc(0, 70, 60, 140, 0, 2*PI);
  popMatrix();
  
     //Left Arm
  fill(penguinArms);
  pushMatrix();
  translate(-110, -30);
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
