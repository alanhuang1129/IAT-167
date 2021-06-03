
void setup() {
  
  size(500, 500);
  background(255);
  
}

void draw() {
  
  pushMatrix();//save state of coordinate system before
  translate(width/2, height/2); //width and height only works if size is set
  rotate(PI/4);
  fill(0);
  rect(-25, -25, 50, 50);
  popMatrix();//restore
  
  pushMatrix();
  translate(3*width/4, 3*height/4); //translate won't affect other code after popMatrix()
  fill(255, 0, 0);
  ellipse(0, 0, 50, 50);
  popMatrix();
  
}
