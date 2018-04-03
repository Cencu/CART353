//To add
//mass
//virus: Eats regular Lives then small life
//.01% chance every frame? increases over time
//reglife-fix bounding box to move with life 
//Large Life: seek small lives and suck life
//to show it is taking life-small balls coming out of smaller life and shrinks
//Give priority over viruses when they appear 
//Mutations? when creating a regular life, have a small chance of being a small or large life
//interactions? 
//aesthetics: lives look like bacterias? Movement-box2d?
//background - microscope
//game start, instructions and end 


//Create the arraylist classes for each life form
ArrayList<RegLife> rLife;
ArrayList<largeLife> lLife;
ArrayList<smallLife> sLife;
ArrayList<virus> v;

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

  sLife = new ArrayList<smallLife>();

  for (int i = 0; i < sLife.size(); i++) {
    sLife.add(new smallLife(width/2, height/2));
  }
  v = new ArrayList<virus>();
  
  for (int i = 0; i < v.size(); i++) {
   v.add (new virus(width/3,height/3)); 
  }
}

void draw() {
  background(255);

  //use an enhanced for loop to loop through their properties
  for (int r = 0; r < rLife.size(); r ++) {
    RegLife rLives = rLife.get(r);
    rLives.dead();

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
    lLives.findFood(rLife, sLife);
    lLives.eat(rLife, sLife);
    lLives.moveLife();
    lLives.findFoodSmall(sLife);
    lLives.eatSmall(sLife);
    lLives.display();
  }

  for (int s = 0; s < sLife.size(); s++) {
    smallLife sLives = sLife.get(s);
    sLives.dead();
    sLives.update();
    sLives.wander();
    sLives.moveLife();
    sLives.display();
  }
  
  for (int vs = 0; vs < v.size(); vs++) {
   virus vrus =  v.get(vs);
   vrus.dead();
   vrus.update();
   vrus.findFood(rLife);
   vrus.eat(rLife);
   vrus.moveLife();
   vrus.display();
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
  if (key == 's' || key == 'S') {
    sLife.add(new smallLife(width/2, height/2));
  }
  if (key == 'v' || key == 'V') {
   v.add(new virus(width/3,height/3)); 
  }
  
  
}