// LAB CHALLENGE
// Change any 3 shapes into 3 completely different (non-repeating) shapes
// However, one of your new shapes must be a curve




void setup() {
  size(600,800);
  background(255);
  
  stroke(42/2, 130/2, 134/2);
  strokeWeight(4);
  fill(42,130,134);
  
  //feet
  arc(300,700,500,300,-radians(180),0,CLOSE);
  
  //body
  ellipse(300,450,300,500);
  
  //left arm
  ellipse(150,500,100,300);
  
  //right arm
  ellipse(450,500,100,300);
  
  //left ear
  ellipse(200,160,100,100);
  
  //right ear
  ellipse(400,165,100,100);
  
  //head
  ellipse(300,200,200,200);
  
  //face
  noStroke();
  fill(199,235,277);
  //First change here (Shape)
  //ellipse(260,200,80,80);
  //ellipse(340,200,80,80);
  rect(230,170,60,60,7);
  rect(310,170,60,60,7);
  
  //snout
  ellipse(300,240,80,80);
  
  //eyes
  fill(120,255,120);
  ellipse(260,200,40,40);
  ellipse(340,200,40,40);
  
  //pupils
  fill(0);
  ellipse(260,200,20,20);
  ellipse(340,200,20,20);
  
  //eye glint
  fill(255);
  ellipse(265,195,5,5);
  ellipse(345,195,5,5);
  
  //nose
  fill(0);
  //Second change here (Shape)
  //triangle(300,240,280,220,320,220);
  circle(300,230,20);
  
  //smile
  noFill();
  stroke(0);
  //Third change here (Curve)
  //arc(300,240,80,80,0,PI);
  bezier(260,240,240,280,360,280,340,240);
  
  //flower stem
  stroke(0,255,0);
  line(400,600,450,300);
  line(450,300,500,350);
  
  //flower
  fill(255,255,0);
  noStroke();
  ellipse(500,350,80,80);
  
  //petals
  fill(255,120,120);
  //facing right petal
  arc(460,350,80,80,radians(30), radians(330));
  //facing left petal
  arc(540,350,80,80,radians(-150),radians(150));
  //facing down petal
  arc(500,310,80,80,radians(-240), radians(60));
  //facing up petal
  arc(500,390,80,80,radians(-60), radians(240));
}
