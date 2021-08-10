class AOE {
  PVector pos;
  int radius;
  int expandingRadius = 0; //starts at 0 and expands to radius
  int expandTimer = 0;
  final int endTimer = 30;
  int ringOffset = 40;
  
  Projectile proj;
  
  AOE(PVector pos, int radius, Projectile proj){
    this.pos = pos;
    this.radius = radius;
    this.proj = proj;
  }
  
  void update() {
    expandingRadius = (int)(radius*((float)expandTimer/((float)endTimer)));
    drawMe();
    if (expandTimer < endTimer) expandTimer++;
    else proj.aoe.remove(this);
    
    if (detectPlayer(p1) && p1.gracePeriod == 60) {
      p1.health -= proj.e.attackPower;
      p1.updateHealthPercentage();
      p1.hit = true;
    }
    
  }
  
  void drawMe() {
    pushMatrix();
    translate(-p1.pos.x + pos.x, -p1.pos.y + pos.y);
    noFill();
    stroke(255, 255, 0, 200);
    strokeWeight(3);
    circle(0, 0, expandingRadius);
    if (expandingRadius > ringOffset) {
      stroke(255, 255, 0, 100);
      circle(0, 0, expandingRadius - ringOffset);
    }
    if (expandingRadius > 2*ringOffset) {
      stroke(255, 255, 0, 50);
      circle(0, 0, expandingRadius - 2*ringOffset);
    }
    popMatrix();
    
    noStroke();
    noFill();
  }
  
  boolean detectPlayer(Player p) {
    return (dist(-p.pos.x + pos.x, -p.pos.y + pos.y, p.pos.x, p.pos.y) <= expandingRadius);
  }
  
}
