//Lab Challenge 2
//1) Make the butterfly follow the mouse directly (Mouse has to be on the butterfly)
//2) Make the head of the bear grow larger as long as you are pressing the mouse
// a) The head should reset once the mouse is released (Holding the mouse press will continually scale up the head size) - Make sure the head scales at the center of the head
//Hint 1: mousePressed and mousePressed() are two different things
//Hint 2: What is the opposite of mousePressed()?


float r = 0.0;//initial bear arm position
float s = 1.0;
color c = color(255, 120, 120);//initial wingColor
int bearHeadTranslation = 120; //set to 110 if you want the center to be the bottom of the nose

/***Extra Segment - I made it so the bear's head will pop after a certain scale threshold and confetti will be shown. After it is popped, the bear head will reform after a short delay. (I also made the other arm move too)***/
float delay = 0;
boolean pop = false;

void setup() {
  size(600, 600);
}

void draw() {
  //math
  r = map(mouseX, 0, width, 0, -PI);
  println(r);
  //draw
  drawBG();
  //Changed drawBear signature for head inflation
  drawBear(r, s);
  drawButterfly(300, 400, c);
  //1)
  drawButterfly(mouseX, mouseY, c);
  
  //2)
  if (mousePressed && pop == false) {
    s += 0.01;
    println("Scale percentage = " + s*100 + "%");
    //Extra effects to make bear head pop
    if (s > 3.0) {
      s = 0;
      pop = true;
      drawConfetti();
    }
    delay = 0;
  }
  //If statement to enforce a timed delay after bear head pops
  if (pop) {
    delay += 0.1;
    drawConfetti(); //Confetti effect after popping
    if (delay > 5.0) {
      pop = false;
    }
    //For debugging use
    println("The bear head has popped: " + pop);
    println("The delay is currently: " + delay);
  }
}

void mousePressed() {
  c = color(random(255),random(255), random(255));
}

//2) a) - Releasing the mouse button will return the scale of the bear's head to normal
void mouseReleased() {
  s = 1.0;
}

//Confetti method
void drawConfetti() {
  strokeWeight(20);
  //upper
  stroke(255,0,0);
  line(100, 30, 200, 90);
  line(500, 30, 400, 90);
  
  //middle
  stroke(255, 255, 0);
  line(90, 140, 200, 140);
  line(510, 140, 400, 140);
  
  //bottom
  stroke(255, 0, 255);
  line(100, 250, 200, 190);
  line(500, 250, 400, 190);
  
  //Return stroke settings
  strokeWeight(5);
  stroke(255, 0, 0);
  
}


void drawBG() {
  
  //background
  background(255); 
  fill(0,0,255);
  rect(100,100,400,450);
  strokeWeight(3);
  stroke(183/2, 114/2, 15);
  fill(183, 114, 30);
}

void drawBear(float rot, float scale) {
  //feet
  arc(300, 350+200, 350, 400, -PI, 0);

  //body
  ellipse(300, 350, 250, 400);

  //arms
  pushMatrix();
  translate(400, 250);
  rotate(rot);
  //ellipse(300+100, 350, 80, 200); //left arm (in reference to the bear)
  ellipse(0, 100, 80, 200);
  popMatrix();
  
  //Little extra part
  pushMatrix();
  translate(200, 250);
  rotate(-rot);
  //ellipse(300-100, 350, 80, 200); //right arm
  ellipse(0, 100, 80, 200);
  popMatrix();


  pushMatrix();
  //Translations before and after scale to set scale to translate from center of the head
  translate(width/2, (height/2) - bearHeadTranslation);
  scale(scale);
  translate(-width/2, -((height/2) - bearHeadTranslation));
  //translate(-(scale - 1)*90, -(scale-1)*90);

  //ears
  ellipse(300+100, 120, 80, 80);
  ellipse(300-100, 120, 80, 80);

  //head
  ellipse(300, 150, 200, 200);
  
  //face
  noStroke();
  fill(247,202,147);
  ellipse(260,150,80,80);
  ellipse(340,150,80,80); 
  ellipse(300,190,80,80);
  
  //irises
  fill(180,180,255);
  ellipse(260,150,30,30);
  ellipse(340,150,30,30);
  
  //pupils
  fill(0); 
  ellipse(260,150,8,8);
  ellipse(340,150,8,8);
  
  //nose
  triangle(300,190,280,170,320,170);
  
  noFill();
  stroke(183/2, 114/2, 15);
  strokeWeight(5);
  arc(300,190,80,80,0,PI);
  
  popMatrix();
}

void drawButterfly(float x, float y, color wingColor) {
  //butterfly
  pushMatrix();
  //added -10 and -40 to translate to shift to center
  translate(x-10,y-40);
  //body
  fill(0);
  rect(0,0,20,80,ROUND);
  
  //attenae
  line(0,0,0,-20);
  noFill();
  arc(-10,-20,20,20,-PI,0);
  line(20,0,20,-20);
  arc(30,-20,20,20,-PI,0);
  
  //wings
  stroke(255,50,50);
  fill(wingColor);
  arc(0,40,80,70,radians(110),radians(250));
  arc(20,40,80,70,radians(-70),radians(70));
  popMatrix();
    
}
