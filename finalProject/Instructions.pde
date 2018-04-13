class Instructions {
  boolean goToGame = false;
  State selection = State.NONE;

  Instructions() {
  }
  void update() {
    display();
  }

  void display() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(80);
    fill(255);
    text("test", width/2, height/2);
  }

  void keyPressed() {
    if  (goToGame) {
      selection = State.PLAYER;
    }
  }

  void keyReleased() {
  }
}