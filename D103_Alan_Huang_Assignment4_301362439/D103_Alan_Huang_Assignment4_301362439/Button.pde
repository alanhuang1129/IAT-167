class Button extends Menu {
  PVector pos, dim;
  String textString;
  color textColor;
  color buttonColor;
  int buttonNumber;
  
  Button(PVector pos, PVector dim, String text) {
    this.pos = pos;
    this.dim = dim;
    textString = text;
    textColor = color(255, 0, 0); //Red by default
    buttonColor = color(220); //A shade of gray by default
  }
  Button(PVector pos, PVector dim, String text, int buttonNumber) {
    this.pos = pos;
    this.dim = dim;
    textString = text;
    textColor = color(255, 0, 0); //Red by default
    buttonColor = color(220); //A shade of gray by default
    this.buttonNumber = buttonNumber;
  }
  Button(PVector pos, PVector dim, String text, color textColor, int buttonNumber) {
    this.pos = pos;
    this.dim = dim;
    textString = text;
    this.textColor = textColor;
    buttonColor = color(220);
    this.buttonNumber = buttonNumber;
  }
  Button(PVector pos, PVector dim, String text, color textColor, color buttonColor, int buttonNumber) {
    this.pos = pos;
    this.dim = dim;
    textString = text;
    this.textColor = textColor;
    this.buttonColor = buttonColor;
    this.buttonNumber = buttonNumber;
  }
  
  boolean detectClick() {
    return (pos.x - dim.x/2 < mouseX &&
            pos.x + dim.x/2 > mouseX &&
            pos.y - dim.y/2 < mouseY &&
            pos.y + dim.y/2 > mouseY &&
            mouseButton == LEFT &&
            !mouseReleased);
  }
  
  void drawMe() {
    textAlign(CENTER);
    textSize(32);
    
    pushMatrix();
    translate(pos.x, pos.y);
    strokeWeight(2);
    stroke(0);
    fill(buttonColor);
    rect(-dim.x/2, -dim.y/2, dim.x, dim.y);
    fill(textColor);
    text(textString, 0, 10);
    
    popMatrix();
  }
}
