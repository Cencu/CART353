class GameOver {
  boolean gameDone = false;

  State selection = State.GAME_OVER;

  GameOver() {
  }

  void update() {
    display();
  }

  void display() {
    background(0);

    textAlign(CENTER, CENTER);
    textSize(80);
    fill(255);
    ellipse(50,50,50,50);
    text("Game", width/2, height/3);
    text("OVER", width/2, height/2.2);
  }
  void keyReleased() {
  }
}