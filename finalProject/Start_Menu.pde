class StartMenu {
  boolean goToInstructions;
  boolean finished = false;

  StartMenu() {
  }
  void update() {
    display();
  }

  void display() {

    background(startPic);
    textAlign(CENTER, CENTER);
    textSize(82);
    text("Critter Colony", width/2, height/3);
    textSize(52);

    text("Press Enter for instructions", width/2, 600);
    textFont(titleFont);
  }

  void keyPressed() {
    if (goToInstructions) {
      finished = true;
    }
  }

  void keyReleased() {
  }
}