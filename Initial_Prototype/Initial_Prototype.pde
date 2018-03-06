


//Create the arraylist classes for each life form
ArrayList<RegLife> rLife;
ArrayList<largeLife> lLife;



void setup() {
  size(1000, 1000);

  //create the arraylist's in the setup
  rLife = new ArrayList<RegLife>();

  //use a for loop to add the lives into the game
  //Specify their starting location
  for (int i = 0; i < rLife.size(); i++) {
    rLife.add(new RegLife(width/2, height/2));
  }
  
    lLife = new ArrayList<largeLife>();

  for (int i = 0; i < lLife.size(); i++) {
    lLife.add(new largeLife(width/2, height/2));
  }
 
}

void draw() {
  background(255);

  //use an enhanced for loop to loop through their properties
  for (int r = 0; r < rLife.size(); r ++) {
    RegLife rLives = rLife.get(r);
    if (rLives.dead()) {
      rLife.remove(r);
    }
    rLives.update();
    rLives.wander();
    //rLives.boundingBox();
    //rLives.bound();
     rLives.createLife(rLife);
    rLives.moveLife();
    rLives.outOfBounds();
    rLives.display();
      
  }
for (int l = 0; l < lLife.size(); l++ ) {
    largeLife lLives = lLife.get(l);
    lLives.update();
    lLives.wander();
    lLives.findFood(rLife);
    lLives.moveLife();
    lLives.eat(rLife);
    lLives.display();
  }

}
//Use keyPress (for now) to create the life forms
void keyPressed() {
  if (key == 'r' || key == 'R') {
    rLife.add(new RegLife(width/2, height/2));
  }
    if (key == 'l' || key == 'L') {
    lLife.add(new largeLife(width/2, height/2));
  }
}