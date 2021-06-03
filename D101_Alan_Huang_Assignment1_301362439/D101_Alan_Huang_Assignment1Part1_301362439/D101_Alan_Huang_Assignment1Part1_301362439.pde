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


void setup() {
  size(600, 600);
}

void draw() {
  //Background
  background(0, 255, 255); 
  
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
  
  
  println(snowFall1);
  snowFall1 += 1;
  snowFall2 += 1;
  snowFall3 += 1;
  snowFall4 += 1;
}
