//Igloo reference - https://i.ytimg.com/vi/1L7EI0vKVuU/maxresdefault.jpg
class Igloo {
  //fields
  int xPos;
  int yPos;
  float scale;
  
  //Constant Variables
  final int iglooWidth = 250;
  final int iglooHeight = 300;
  //Constructors
  Igloo(int xPos, int yPos, float scale) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.scale = scale;
  }
  Igloo() {
    xPos = width/2;
    yPos = height/2;
    scale = 1.0;
  }
  //Methods
  //This method is created to reduce lag for overlapping igloos over the penguin (Igloos are drawn over the penguin if Igloo's Y coordinate is bigger)
  //Adding this proximity condition reduces the amount of igloos printed as it will draw for every penguin that has a smaller Y value
  boolean detectProximity(int x, int y) {
    if (dist(x, y, xPos, yPos) < (iglooHeight)*scale) {
      return true;
    }
    else return false;
  }
  void drawMe() {
    pushMatrix();
    translate(xPos, yPos);
    scale(this.scale);
    fill(snowColor);
    stroke(iglooOutline);
    strokeWeight(2);
    arc(0, 0, iglooWidth, iglooHeight, radians(160), radians(380), CHORD);
    
    //brick outlines
    noFill();
      //horizontal
    
    line(-70, -125, 70, -125);
    line(-100, -90, 100, -90);
    line(-115, -55, 115, -55);
    line(-124, -20, 124, -20);
    line(-124, 15, 124, 15);
    
      //vertical
    line(-16, -149, -27, -125);
    line(16, -149, 27, -125);
      
    line(-43, -125, -63, -90);
    line(0, -125, 0, -90);
    line(43, -125, 63, -90);
    
    line(-85, -90, -100, -55);
    line(-30, -90, -38, -55);
    line(85, -90, 100, -55);
    line(30, -90, 38, -55);
    
    line(-85, -55, -93, -20);
    line(-34, -55, -36, -20);
    line(85, -55, 93, -20);
    line(34, -55, 36, -20);
    
    line(0, -20, 0, 15);
    line(53, -20, 57, 15);
    line(112, -20, 123, 15);
    
    line(20, 15, 20, 50);
    line(20, 15, 20, 50);
    line(73, 15, 77, 50);
    
    fill(snowColor);
    
    
    
    //archway
    arc(-50, 30, 80, 130, radians(160), radians(380), CHORD);
    line(-110, -35, -55, -35);
    noStroke();
    rect(-110, -34, 60, 86);
    stroke(iglooOutline);
    strokeWeight(2);
    arc(-110, 30, 80, 130, radians(160), radians(380), CHORD);
  
    //lines on arch
    fill(snowColor);
    line(-84, -18, -24, -18);
    line(-70, 25, -10, 25);
    curve(-70, -10, -52, -18, -43, 25, -70, 80);
    
    line(-70, 25, -83, 26);
    line(-150, 25, -138, 26);
    
    line(-84, -18, -93, -5);
    line(-138, -18, -128, -5);
    
    line(-110, -34, -110, -18);
    
    //arch entrance
    fill(0);
    arc(-110, 35, 80*0.7, 130*0.85, radians(160), radians(380), CHORD);
    popMatrix();
  }
  
  int getY() { //Floor of the igloo
    int floor = (int)(yPos + 50*scale);
    return floor;
  }
}
