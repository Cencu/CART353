import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.sound.*;
import sprites.*;
import sprites.maths.*;
import sprites.utils.*;

/////ArrayLists and Classes\\\\\
ArrayList<RegLife> rLife;
ArrayList<largeLife> lLife;
ArrayList<smallLife> sLife;
ArrayList<virus> v;
additionalContent aC;
player pl;
State state;
StartMenu startMenu;
Instructions instructions;
GameOver gameOver;
player playerGame;
//Sprites class for regular lives
Sprite avatar;

//Stopwatch to time the sequence of frames
StopWatch times = new StopWatch();
//StopWatch times2 = new StopWatch();

//Sound Files\\
SoundFile lLifeHunger;
SoundFile lLifeAlert;
SoundFile lLifedeplete;
SoundFile lLifespawn;

SoundFile sLifeSpawn;
SoundFile sLifedead;

SoundFile rLifeSpawn;
SoundFile rLifedeplete;

SoundFile virusSpawn;

SoundFile random1;
SoundFile random2;
SoundFile random3;
SoundFile random4;

Minim minim;
AudioPlayer[] music = new AudioPlayer[3];
int count =0;
AudioPlayer music0;
AudioPlayer music1;
AudioPlayer music2;

//Images\\
PImage startPic;
PImage gamePic;

//Font\\
PFont titleFont;
PFont instructionFont;

//Spawn Virus\\
float r;
float rV = 7000;



//Checks how many lives have been placed
int maxPlaced = 0;
int regPlaced = 0;
int smallPlaced = 0;
int largePlaced = 0;

//Title screens of the game
enum State {
  NONE, 
    START_MENU, 
    INSTRUCTIONS, 
    PLAYER, 
    GAME_OVER
}

void setup() {
  size(1200, 900);
  minim = new Minim(this); 

  //Background Images
  startPic = loadImage("backgroundstart.jpg");
  startPic.resize(1200, 900);
  gamePic = loadImage("petri.png");
  gamePic.resize(1200, 900);

  //Fonts
  titleFont = createFont("Radioactive-Regular.ttf", 50);
  instructionFont = createFont("HelveticaLTStd-Light.otf", 50);

  //Game Screens, as classes
  startMenu = new StartMenu();
  instructions = new Instructions();
  gameOver = new GameOver();
  playerGame = new player();
  //Start the game state in the start menu
  state = State.START_MENU;

  //create the arraylist's in the setup
  rLife = new ArrayList<RegLife>();
  //Load the avatar
  avatar = new Sprite(this, "reglife.png", 24, 1, 1);
  //set the frame sequence
  avatar.setFrameSequence(0, 1);

  //use a for loop to add the lives into the game
  //Specify their starting location
  for (int i = 0; i < rLife.size(); i++) {
    rLife.add(new RegLife(width/2, height/2));
  }

  //Call the arrayList again and do this for the other critters
  lLife = new ArrayList<largeLife>();
  for (int i = 0; i < lLife.size(); i++) {
    lLife.add(new largeLife("lLife", width/2, height/2, 116));
  }

  sLife = new ArrayList<smallLife>();
  for (int i = 0; i < sLife.size(); i++) {
    sLife.add(new smallLife("sLife", width/2, height/2, 20));
  }

  v = new ArrayList<virus>();
  for (int i = 0; i < v.size(); i++) {
    v.add (new virus("virus", width/3, height/3, 9));
  }

  //Additional Content is the timer
  aC = new additionalContent();

  //Call in the player class
  pl = new player(width/2, height/2);

  //Load in all the sound files
  //Changed the amplitude because they were too loud
  rLifedeplete = new SoundFile(this, "rLifedeplete.wav");
  rLifedeplete.amp(.03);

  rLifeSpawn = new SoundFile(this, "rLifespawn.wav");
  rLifeSpawn.amp(.03);

  lLifeHunger = new SoundFile(this, "lLifeHnger.wav");
  lLifeHunger.amp(.001);


  lLifeAlert= new SoundFile (this, "lLifeAlter.wav");
  lLifeAlert.amp(.1);
  lLifedeplete = new SoundFile (this, "lLifedeplete.wav");
  lLifedeplete.amp(.1);

  lLifespawn = new SoundFile (this, "lLifespawn.wav");
  lLifespawn.amp(.1);

  sLifedead = new SoundFile (this, "sLifedead.wav");
  sLifedead.amp(.1);
  sLifeSpawn = new SoundFile(this, "sLifespawn.wav");
  sLifeSpawn.amp(.01);


  virusSpawn = new SoundFile(this, "virusalarm.mp3");
  virusSpawn.amp(.3);

  random1 = new SoundFile(this, "random0.mp3");
  random2 = new SoundFile(this, "random1.mp3");
  random3 = new SoundFile(this, "random2.wav");
  random4 = new SoundFile(this, "random3.mp3");

  music0 = minim.loadFile("music0.mp3");
  music1 = minim.loadFile("music1.mp3");
  music2 = minim.loadFile("music2.mp3");
  music0.play();
}

void draw() {
  //method for looping through music 

  if (!music0.isPlaying()) {
    music1.play();
  } 
  if (music1.position() >= music1.length()-5) {
    music2.play();
  }
  if (music2.position() >= music1.length()-5) {
    music0.play();
  }

  //Switch between the game screens of the game using a switch statment and state as the name which call the screen 
  switch (state) {
    //If we are in no state then we break out of the loop and switch to the start menu state 
  case NONE:
    break;
    //Once the start menu is finished (by pressing enter) we switch to the instructions 
  case START_MENU:
    //Update calls the display method
    startMenu.update();
    if (startMenu.finished) {
      state = State.INSTRUCTIONS;
    }
    break;

    //When we are in the instructions display it with update
    //then to the state as NONE so it works
    //we then switch to player when we press A
  case INSTRUCTIONS:
    instructions.update();
    if (instructions.selection != State.NONE) {
      state = instructions.selection;
      instructions.selection = State.NONE;
      state = State.PLAYER;
    }
    break;
    //Case player is the game, when the game is over we switch to the game over screen 
  case PLAYER:
    if (instructions.selection == State.NONE) {
      if (!gameOver.gameDone) {
        //use the background as an image
        background(gamePic);

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
          //Call all the methods
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
          vrus.findFood(rLife, sLife, pl);
          vrus.eat(rLife, sLife);
          vrus.eatSmall(sLife);
          vrus.eatPlayer(pl);
          vrus.offScreen();
          vrus.moveLife();
          vrus.display();
        }

        //A way of spawning in the virus at random times
        //If r lands on 1 then a virus spawns in 
        //R chooses a random number between 0 and 7000
        //7000 also decreases so theres more of a likelyhood that one will be chosen
        r = floor(random(199, rV));
        rV -=.02;
        if (r == 200) {
          v.add(new virus("virus", width/3, height/3, 9));
          virusSpawn.play();
        } 
        //player and timer classes
        aC.timer(instructions);

        pl.randomSounds();
        pl.movement();
        pl.moveLife(rLife, sLife, lLife);
        pl.offScreen();
        pl.display();
        pl.ifDead(gameOver);
        //When the game is done we switch the state again
        if (gameOver.gameDone) {
          state = State.GAME_OVER;
        }
      }
    }

    break;
  case GAME_OVER:
    gameOver.update();
    break;
  }
}

void keyPressed() {
  switch(state) {
  case NONE:
    break;

  case START_MENU:
    startMenu.keyPressed();
    if (key == ENTER) {
      startMenu.goToInstructions = true;
    }
    break; 

  case INSTRUCTIONS:
    instructions.keyPressed();
    if (key == 'a' || key == 'A') {
      instructions.goToGame = true;
    }
    break;
  case GAME_OVER:
    break;
  case PLAYER:

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
        sLife.add(new smallLife("sLife", width/2, height/2, 20));
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
    } 
    if (keyCode == SHIFT) {
      pl.shifted = true;
    }


    if (key == 'v' || key == 'V') {
      v.add(new virus("virus", width/3, height/3, 9));
      virusSpawn.play();
    }
    break;
  }
}

void keyReleased() {
  switch (state) {

  case NONE:
    break;

  case START_MENU:
    startMenu.keyReleased();

    break;

  case INSTRUCTIONS:
    instructions.keyReleased();
    break;
  case GAME_OVER:
    gameOver.keyReleased();
    break;
  case PLAYER:


    if (keyCode == LEFT) {
      pl.goLeft = false;
    } 
    if (keyCode == RIGHT) {
      pl.goRight = false;
    } 
    if (keyCode == UP) {
      pl.goUp = false;
    }  
    if (keyCode == DOWN) {
      pl.goDown = false;
    }
    if (keyCode == SHIFT) {
      pl.shifted = false;
    }

    break;
  }
}