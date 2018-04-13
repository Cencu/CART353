import processing.sound.*;

import sprites.*;
import sprites.maths.*;
import sprites.utils.*;

//R spawns regular lives
//S small
//V viruses
//L large lives



//Create the arraylist classes for each life form
ArrayList<RegLife> rLife;
ArrayList<largeLife> lLife;
ArrayList<smallLife> sLife;
ArrayList<virus> v;
//Extras put in the game
additionalContent aC;
player pl;

//Sprites class for small and regular lives
Sprite avatar;
Sprite smallAvatar;
//Stopwatch to time the sequence of frames
StopWatch times = new StopWatch();
StopWatch times2 = new StopWatch();

//Sound Files
SoundFile lLifeHunger;
SoundFile rLifedeplete;
SoundFile sLifeSpawn;
SoundFile lLifeAlert;
SoundFile lLifedeplete;
SoundFile lLifespawn;
SoundFile sLifedead;
SoundFile rLifeSpawn;


//Random number chosen for virus to appear
float r;
float rV = 5000;


boolean placed = false;

//Checks how many lives have been placed
int maxPlaced = 0;
int regPlaced = 0;
int smallPlaced = 0;
int largePlaced = 0;

void setup() {
  size(1000, 1000);

  //create the arraylist's in the setup
  rLife = new ArrayList<RegLife>();
  //Load the avatar
  avatar = new Sprite(this, "reglife.png", 24, 1, 1);
  //set the frame sequence
  avatar.setFrameSequence(0, 200);
  //use a for loop to add the lives into the game
  //Specify their starting location
  for (int i = 0; i < rLife.size(); i++) {
    rLife.add(new RegLife(width/2, height/2));
  }
//Call the arrayList again
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
  pl = new player(width/2,height/2);
//Load in all the sound files
//Changed the amplitude because they were too loud
  rLifedeplete = new SoundFile(this, "rLifedeplete.wav");
  rLifedeplete.amp(.03);//used

  rLifeSpawn = new SoundFile(this,"rLifespawn.wav");
  rLifeSpawn.amp(.1);

  lLifeHunger = new SoundFile(this, "lLifeHnger.wav");
  lLifeHunger.amp(.001);//used


  lLifeAlert= new SoundFile (this, "lLifeAlter.wav");
  lLifeAlert.amp(.1);//used
  
  lLifedeplete = new SoundFile (this, "lLifedeplete.wav");
  lLifedeplete.amp(.1);//used
  
  lLifespawn = new SoundFile (this, "lLifespawn.wav");
  lLifespawn.amp(.1);//used
  
  sLifedead = new SoundFile (this, "sLifedead.wav");
  sLifedead.amp(.1);//used
  sLifeSpawn = new SoundFile(this, "sLifespawn.wav");
  sLifeSpawn.amp(.01);//used
}

void draw() {
  background(255);

  //use for loop to loop through their properties
  for (int r = 0; r < rLife.size(); r ++) {
    RegLife rLives = rLife.get(r);
    //Draw the sprites based on the stopwatch
    double deltaTime = times.getElapsedTime();
    //update based on stopwatch time
    S4P.updateSprites(deltaTime);
    //draw the sprites
    S4P.drawSprites();
    //set the frame sequence based on the number of frames and the speed each frame is shown
    avatar.setFrameSequence(24, 1, .1);

    rLives.dead();
    rLives.update();
    rLives.wander();
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
    smallAvatar.setFrameSequence(22, 1, .08);
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
    vrus.findFood(rLife, sLife,pl);
    vrus.eat(rLife, sLife);
    vrus.eatSmall(sLife);
    vrus.eatPlayer(pl);
    vrus.offScreen();
    vrus.moveLife();
    vrus.display();
  }

  aC.timer();
  aC.lifeList();
  
  pl.display();
  pl.movement();
  pl.moveLife(rLife, sLife, lLife);
  pl.offScreen();
//A way of spawning in the virus at random times
//If r lands on 1 then a virus spawns in 
//R chooses a random number between 0 and 5000
//5000 also decreases so theres more of a likelyhood that one will be chosen
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
      rLifeSpawn.play();
    }
    if (key == 'l' || key == 'L') {
      lLife.add(new largeLife("lLife", width/2, height/2, 116));
      maxPlaced +=1;
      largePlaced +=1;
      lLifespawn.play();
    }
    if (key == 's' || key == 'S') {
      sLife.add(new smallLife(width/2, height/2));
      maxPlaced +=1;
      smallPlaced +=1;
      sLifeSpawn.play();
    }
  }
  
  if (keyCode == LEFT) {
    pl.goLeft = true;
  }
  if (keyCode == RIGHT) {
    pl.goRight = true;
  }
  if (keyCode == UP) {
    pl.goUp = true;
  }
  if (keyCode == DOWN) {
   pl.goDown = true; 
  } if (keyCode == SHIFT) {
   pl.shifted = true; 
  }

  
  if (key == 'v' || key == 'V') {
    v.add(new virus("virus", width/3, height/3, 9));
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
   pl.goLeft = false; 
  } if (keyCode == RIGHT) {
    pl.goRight = false;
  } if (keyCode == UP) {
   pl.goUp = false; 
  }  if (keyCode == DOWN) {
   pl.goDown = false; 
  }if (keyCode == SHIFT) {
   pl.shifted = false; 
  }
  
  
}