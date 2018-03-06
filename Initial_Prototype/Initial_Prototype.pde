


//Create the arraylist classes for each life form
ArrayList<RegLife> rLife;



void setup() {
  size(1000, 1000);

  //create the arraylist's in the setup
  rLife = new ArrayList<RegLife>();

  //use a for loop to add the lives into the game
  //Specify their starting location
  for (int i = 0; i < rLife.size(); i++) {
    rLife.add(new RegLife(width/2, height/2));
  }
}

void draw() {
  background(255);

  //use an enhanced for loop to loop through their properties
  for (int r = 0; r < rLife.size(); r ++) {
    RegLife rLives = rLife.get(r);
    rLives.update();
    rLives.wander();
    rLives.boundingBox();
    // rLives.createLife(rLife);

    rLives.moveLife();
    rLives.display();
  }
}
//Use keyPress (for now) to create the life forms
void keyPressed() {
  if (key == 'r' || key == 'R') {
    rLife.add(new RegLife(width/2, height/2));
  }
}