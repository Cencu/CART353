import sprites.*;
import sprites.maths.*;
import sprites.utils.*;

//R spawns regular lives
//S small
//V viruses
//L large lives


//To add

//reglife-fix bounding box to move with life 
//to show it is taking life-small balls coming out of smaller life and shrinks
//interactions? 
//aesthetics: lives look like bacterias? Movement-box2d?
//background - microscope
//game start, instructions and end 


//Create the arraylist classes for each life form
ArrayList<RegLife> rLife;
ArrayList<largeLife> lLife;
ArrayList<smallLife> sLife;
ArrayList<virus> v;
additionalContent aC;

Sprite avatar;
Sprite smallAvatar;
StopWatch times = new StopWatch();
StopWatch times2 = new StopWatch();

float avatarSpeed =1;

float r;
boolean placed = false;
float rV = 5000;

int maxPlaced = 0;
int regPlaced = 0;
int smallPlaced = 0;
int largePlaced = 0;

void setup() {
  size(1000, 1000);



  //create the arraylist's in the setup
  rLife = new ArrayList<RegLife>();
  avatar = new Sprite(this, "reglife.png", 24, 1, 1);
  avatar.setFrameSequence(0, 1);
  //use a for loop to add the lives into the game
  //Specify their starting location
  for (int i = 0; i < rLife.size(); i++) {
    rLife.add(new RegLife(width/2, height/2));
  }

  lLife = new ArrayList<largeLife>();

  for (int i = 0; i < lLife.size(); i++) {
    lLife.add(new largeLife("lLife", width/2, height/2, 116));
  }

  sLife = new ArrayList<smallLife>();

  for (int i = 0; i < sLife.size(); i++) {
    sLife.add(new smallLife(width/2, height/2));
  }
  smallAvatar = new Sprite(this, "sLife.png", 22, 1, 1);
  smallAvatar.setFrameSequence(0, 1);

  v = new ArrayList<virus>();

  for (int i = 0; i < v.size(); i++) {
    v.add (new virus("virus", width/3, height/3, 9));
  }
  aC = new additionalContent();
}

void draw() {
  background(255);

  //use an enhanced for loop to loop through their properties
  for (int r = 0; r < rLife.size(); r ++) {
    RegLife rLives = rLife.get(r);
    double deltaTime = times.getElapsedTime();
    S4P.updateSprites(deltaTime);
    S4P.drawSprites();
    avatar.setFrameSequence(24, 5, .1);

    rLives.dead();

    rLives.update();
    rLives.wander();
    //rLives.boundingBox();
    //rLives.bound();
    //rLives.runFromVirus(v);
    rLives.createLife(rLife);
    rLives.moveLife();
    rLives.offScreen();
    rLives.display();
  }  
  for (int l = 0; l < lLife.size(); l++ ) {
    largeLife lLives = lLife.get(l);
    lLives.update();
    lLives.wander();
    lLives.findFood(rLife, sLife, v);
    lLives.eat(rLife);
    lLives.eatV(v);

    lLives.moveLife();
    lLives.eatSmall(sLife);
    lLives.offScreen();
    lLives.died();
    lLives.display();
  }

  for (int s = 0; s < sLife.size(); s++) {
    smallLife sLives = sLife.get(s);
    double deltaTime2 = times2.getElapsedTime();
    S4P.updateSprites(deltaTime2);
    S4P.drawSprites();
    smallAvatar.setFrameSequence(22, 5, .08);
    if (sLives.health >= 5) {
      placed = true;
    } 
    if (sLives.health > 1 && sLives.health < 4) {
      placed = false;
    }
    sLives.dead();
    sLives.update();
    sLives.wander();
    sLives.moveLife();
    sLives.offScreen();
    sLives.display();
  }

  for (int vs = 0; vs < v.size(); vs++) {
    virus vrus =  v.get(vs);

    vrus.dead();
    vrus.update();
    vrus.findFood(rLife, sLife);
    vrus.eat(rLife, sLife);
    vrus.eatSmall(sLife);
    vrus.offScreen();
    vrus.moveLife();
    vrus.display();
  }

  aC.timer();
  aC.lifeList();
  r = floor(random(0, rV));
  rV -=.02;
  if (r == 1) {
    v.add(new virus("virus", width/3, height/3, 9));
  } else {
    return;
  }
}

void keyPressed() {
  if (maxPlaced <= 15) {

    if (key == 'r' || key == 'R') {
      rLife.add(new RegLife(width/2, height/2));
      maxPlaced +=1;
      regPlaced +=1;
    }
    if (key == 'l' || key == 'L') {
      lLife.add(new largeLife("lLife", width/2, height/2, 116));
      maxPlaced +=1;
      largePlaced +=1;
    }
    if (key == 's' || key == 'S') {
      sLife.add(new smallLife(width/2, height/2));
      maxPlaced +=1;
      smallPlaced +=1;
    }
  }
  if (key == 'v' || key == 'V') {
    v.add(new virus("virus", width/3, height/3, 9));
  }
}