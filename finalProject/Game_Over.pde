class GameOver {
  boolean gameDone = false;

  State selection = State.GAME_OVER;

  GameOver() {
  }

  void update() {
    display(aC);
  }
  //Display the score which is the time you survived 
  void display(additionalContent aC) {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(80);
    fill(255);
    text("Game Over", width/2-10, height/3);
    text("Score:", width/2-125, height/2);
    text(nf(aC.displayTimeM, 2) + ":" + nf(aC.displayTimeS, 2), width/2+100, height/2);
  }
  void keyReleased() {
  }
}