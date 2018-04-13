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
    textSize(25);
    fill(255);
    text("Welcome to Critter Colony, where you have the power to control", width/2, 100);
    text("and create life forms!", width/2, 150);
    text("R spawns in regular lives, which have the power to create more lives.", width/2, 200);
    text("L spawns in large lives, which defend the other critters.", width/2, 250);
    text("S spawns in small lives, which feed the large lives.", width/2, 300);
    text("You can move your player with the arrow keys and move the critters around by going on", width/2, 350);
    text("top of them and pressing shift", width/2, 400);
    text("Viruses spawn in randomly, but as the time goes on, the chances of them coming to", width/2, 450);
    text("destroy your colony increase!",width/2,500);
    text("They will target your regular lives first, then the small, then the player", width/2, 550);
    text("If the player dies, the game is over.", width/2, 600);
    text("If you want to expiriment, you can press V to spawn them in at will.", width/2, 650);
    text("Lastly, if trying to move the critters with your character proves too difficult", width/2, 700);
    text("you can move them with the mouse.", width/2, 750);
    text("Press A to continue to the game!", width/2,800);


    textFont(instructionFont);
  }

  void keyPressed() {
    if  (goToGame) {
      selection = State.PLAYER;
    }
  }

  void keyReleased() {
  }
}