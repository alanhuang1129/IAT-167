class Score {
  //fields
  int xPos; //Positions of the text
  int yPos;
  int score;
  PFont font;
  int size;
  
  //Constructors
  Score() {
    xPos = width/2;
    yPos = 100;
    score = 0;
  }
  Score(int x, int y, int fontSize) {
    xPos = x;
    yPos = y;
    score = 0;
    size = fontSize;
  }
  //Methods
  void setFont(PFont font) {
    this.font = font;
  }
  void displayScore() {
    pushMatrix();
    translate(xPos, yPos);
    //textFont(font);
    textSize(size);
    text("Score: " + score, 0, 0);
    popMatrix();
  }
  void setFontSize(int fontSize) {
    size = fontSize;
  }
  void incrementScore() {
    score += 1;
  }
  void resetScore() {
    score = 0;
  }
}
