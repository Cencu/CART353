class StartMenu {
  boolean goToInstructions;
  boolean finished = false;
 // State selection = State.NONE;

  StartMenu() {
  }
  void update() {
    display();
  }

  void display() {
    background(0);
    textAlign(CENTER,CENTER);
    textSize(32);
    text("Critter Colony",width/2,height/2);
    
     text("Press Enter for instructions", width/2,height/3);
  }
  
  void keyPressed() {
   if (goToInstructions) {
     finished = true;
   }
  }
  
  void keyReleased() {
    
  }
}