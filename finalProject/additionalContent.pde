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
//A timer where we convert seconds to millis
//minutes to seconds
    seconds = millis()/1000;
    mins = millis()/1000/60;
    //display time for the seconds, which is subtracted by the restart seconds 
    //restarts the seconds when they reach 60
    displayTimeS = seconds-restartSec;
    //Changes the minutes when it reaches 60
    displayTimeM = mins-restartMin;
    if (seconds % 60 == 0) {
      restartSec = seconds; 
      displayTimeS = startSec;
    }

    textAlign(CENTER);
    fill(0);
    textSize(25);
    text(nf(displayTimeM, 2) + ":" + nf(displayTimeS, 2), 950, 950);
  }


  void lifeList() {
    textSize(10);
    text("Regular Lives" + " "+ nf(regPlaced, 2), 50, 50);
    text("Small Lives" + " " + nf(smallPlaced, 2), 45, 70);
    text("Large Lives" + " " + nf(largePlaced, 2), 45, 90);
  }
}