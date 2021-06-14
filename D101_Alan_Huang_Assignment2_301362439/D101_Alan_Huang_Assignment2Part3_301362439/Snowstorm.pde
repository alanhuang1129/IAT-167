class Snowstorm {
  //fields
  final int delay = 100; //delay - not really meant to be changed (const)
  final float snowFallSpeed = 10.0;
  int timeInterval;
  int delayCoefficient;
  final int snowIntensity = 12; // >= 1 (how many snowballs spawn in each set)
  float snowTimer;
  int[] rand = new int[snowIntensity];
  int[] randSpeed = new int[snowIntensity];
  //Constructors
  Snowstorm() {
    timeInterval = 90;
    delayCoefficient = 0;

    snowTimer = 0.0;
  }
  Snowstorm(int interval, int delayCoeff) {
    timeInterval = interval;
    delayCoefficient = delayCoeff;
    snowTimer = 0.0;
  }
  
  
  //Methods
  void newRandomValues() {
    for (int i = 0; i < snowIntensity; i++) {
      rand[i] = (int)random(100, width);
      randSpeed[i] = (int)random(80, 120);
    }
  }
  
  void updateTimer(float timer) {
    snowTimer = timer;
    snowTimer %= timeInterval*delayCoefficient;
    if (snowTimer < 1) {
      newRandomValues();
    }
  }
  void drawMe() {
    noStroke();
    fill(snowColor);
    //First Set of snow
    //snowTimer/50) % 3 == 2
    //snowTimer%(timeInterval + delay*delayCoefficient)
    /*
    if (snowTimer%(timeInterval + delay*delayCoefficient) == 0) {//As snowFall reaches timeInterval -> reset snowfall with random values
      snowTimer = 0.0;
    }
    for (int i = 0; i < snowIntensity; i++) { //Production of snow
      circle(rand[i] - snowTimer, snowTimer*randSpeed[i]*0.01*snowFallSpeed, 10);
    }
    */
    for(int i = 0; i < snowIntensity; i++) {
      circle(rand[i] - snowTimer, snowTimer*randSpeed[i]*0.01*snowFallSpeed, 10);
    }
  }
}
