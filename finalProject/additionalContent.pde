class additionalContent {

  int seconds;
  int mins;
  int startSec = 0;
  int startMins = 0;
  int displayTimeS;
  int displayTimeM;
  int restartSec = 0;



  additionalContent() {
  }



  void timer(Instructions i) {
    //A timer where we convert seconds to millis
    //minutes to seconds
    seconds = millis()/1000;
    mins = millis()/1000/60;
    //display time for the seconds, which is subtracted by the restart seconds 
    //restarts the seconds when they reach 60
    displayTimeS = seconds-restartSec;
    //Changes the minutes when it reaches 60
    displayTimeM = mins;
    //when seconds is larger than 60 it will equal to zero, since it cannot be larger than itself
    //When it reaches 0, the counter restarts the seconds 
    if (i.goToGame) {
          restartSec = seconds; 
    }
        i.goToGame = false;
     if (seconds % 60 == 0) {
      //restartsecs = 0 so it reverts back to 0
      restartSec = seconds; 
      //Displays as 0
      displayTimeS = startSec;
    }
    

    textAlign(CENTER);
    fill(0);
    textSize(25);
    //Display the timer of minutes and seconds
    text(nf(displayTimeM, 2) + ":" + nf(displayTimeS, 2), 950, 950);
  }


  void lifeList() {
    textSize(10);
    //Shows you how many lives are currently on the screen
    //does not include the ones created using the lives
    //Input the text as a string, NF converts the numbers to integers and 2 is how many integers you would like to show
    //50,50 is the location
    text("Regular Lives" + " "+ nf(regPlaced, 2), 50, 50);
    text("Small Lives" + " " + nf(smallPlaced, 2), 45, 70);
    text("Large Lives" + " " + nf(largePlaced, 2), 45, 90);
  }
}