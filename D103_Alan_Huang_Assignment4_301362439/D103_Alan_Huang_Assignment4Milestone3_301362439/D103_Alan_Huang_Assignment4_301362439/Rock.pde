class Rock extends StationaryObject {
  int health;
  int gracePeriodTimer = -1;
  boolean hitFeedback = false;
  boolean criticalHitFeedback = false;
  boolean lingeringEffect = false; //used to keep the fading critical hit effect
  
  Rock(PVector pos, PVector dim) {
    super(pos, dim);
    objectType = ROCK_TYPE;
    //dim = new PVector(60, 75);
    health = 4;
  }
  
  void drawMe() {
    pushMatrix();
    fill(89, 60, 31);
    translate(pos.x, pos.y);
    arc(0, 0, dim.x, dim.y, 3*PI/4, 9*PI/4, CHORD);
    
    popMatrix();
  }
  
  void drawMe(Player p) {
    pushMatrix();
    fill(89, 60, 31);
    stroke(0);
    strokeWeight(1);
    translate(-p.pos.x + pos.x, -p.pos.y + pos.y);
    
    if (criticalHitFeedback == true) {
      lingeringEffect = true;
      //fill(255, 0, 0, gracePeriodTimer*255/30);
    } 
    else {
      if (hitFeedback == true && !lingeringEffect) { //Feedback of hit detection
        fill(255, 255, 0, gracePeriodTimer*255/30);
      }
    }
    if (lingeringEffect == true) {
      fill(255, 0, 0, gracePeriodTimer*255/30);
    }
    
    arc(0, 0, dim.x, dim.y, 3*PI/4, 9*PI/4, CHORD);
    fill(89, 60, 31);
    
    popMatrix();
  }
  
  void update() {
    super.update(p1);
    if (gracePeriodTimer != -1) {
      gracePeriodTimer--;
      hitFeedback = true;
    }
    else {
      hitFeedback = false;
      criticalHitFeedback = false;
      lingeringEffect = false;
    }
    if (health <= 0 && !(this instanceof Ore)) {
      itemDrops.add(new ItemDrop(pos, STONE));
      gw.objects.remove(this);
    }
  }
}
