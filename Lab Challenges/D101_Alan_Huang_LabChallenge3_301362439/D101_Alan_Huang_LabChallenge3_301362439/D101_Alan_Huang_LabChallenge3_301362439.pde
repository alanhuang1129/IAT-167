//LAB CHALLENGE:
//1) When you hit the RIGHT mouse button on the butterfly, butterflies move DOWN instead
//2) Instead of disappearing off the screen, the butterflies loop around to the other side of the screen (They don't need to stop)

int butterflyWidth=100; //diameter of "wing" arc, plus width of rect. body
int numButterflies=5; 

//int xcoords;
//int ycoords;
//int speed;
int[] xcoords = new int[numButterflies];
int[] ycoords = new int[numButterflies];
int[] speeds = new int[numButterflies];

void setup() {
  //xcoords= (int)random(butterflyWidth/2, width - butterflyWidth/2);
  //ycoords = (int)random(butterflyWidth/2, height - butterflyWidth/2);
  for(int i = 0; i < numButterflies; i++) {
    xcoords[i] = (int)random(butterflyWidth/2, width - butterflyWidth/2);
    ycoords[i] = (int)random(butterflyWidth/2, width - butterflyWidth/2);
  }
}

void settings() {
  size(butterflyWidth+numButterflies*butterflyWidth, 600);
}

void draw() {
  fill(120, 120, 255, 50);
  rect(0, 0, width, height); //this will be our background. 
  //Will create a cool effect when we aniate our butterflies. :)
  //HIT DETECTION
  for (int i = 0; i < numButterflies; i++) {
    int bx = xcoords[i];
    int by = ycoords[i];
    
    if(mousePressed && dist(mouseX, mouseY, bx, by) < butterflyWidth/2) {
      speeds[i] = -5;
    }
    ycoords[i] += speeds[i];
    drawButterfly(bx, by);
  }
}


void drawButterfly(float x, float y) {
  //butterfly
  pushMatrix();
  translate(x, y);
  //body
  fill(0);
  stroke(0);
  rect(-10, -40, 20, 80, ROUND);

  //attenae
  line(-10, -40, -10, -60);
  noFill();
  arc(-20, -60, 20, 20, -PI, 0);
  line(10, -40, 10, -60);
  arc(20, -60, 20, 20, -PI, 0);

  //wings
  stroke(255, 50, 50);
  fill(255, 120, 120, 180);
  arc(-10, 0, 80, 70, radians(110), radians(250));
  arc(10, 0, 80, 70, radians(-70), radians(70));
  popMatrix();
}
