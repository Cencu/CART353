class additionalContent {
  
  int seconds;
  int mins;
  int startSec = 0;
  int startMins = 0;
  int displayTimeS;
  int displayTimeM;
  int restartSec = 0;
  int restartMin = 0;



  additionalContent() {
  }



  void timer() {
    seconds = millis()/1000;
    mins = millis()/1000/60;
    displayTimeS = seconds-restartSec;
    displayTimeM = mins-restartMin;
    if (seconds % 60 == 0) {
     restartSec = seconds; 
     displayTimeS = startSec;
    }
    textAlign(CENTER);
    fill(0);
    textSize(25);
    text(nf(displayTimeM,2) + ":" + nf(displayTimeS,2),950,950);
  }
  
  
  
  
  
  
  
  
}