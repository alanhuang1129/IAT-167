class Score {
  PFont font = createFont("MicrosoftYaHeiLight-48", 32); //This font is given by processing's font library
  PVector textPos;
  int size;
  int score;
  
  Score(PVector pos) {
    textPos = pos;
    size = 32;
    score = 0;
  }
  Score(PVector pos, int textSize) {
    textPos = pos;
    size = textSize;
    score = 0;
  }
  void drawScore(){
    pushMatrix();
    translate(textPos.x, textPos.y);
    textSize(size);
    textAlign(CENTER);
    text("Score: " + score, 0, 0);

    popMatrix();
  }
  
  void incrementScore() {
    score += 50;
  }
  void resetScore() {
    score = 0;
  }
  int getScore() {
    return score;
  }
}
