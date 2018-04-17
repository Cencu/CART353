class player {

  //PVectors for location, velocity, acceleration and size
  PVector posi;
  PVector velo;
  PVector accel;
  PVector size;
  //Speed, mass and health of the player
  float speed;
  float mass;
  float health = 255;
  //Variables of movement 
  PVector forward = new PVector(0.05, 0);
  PVector backwards = new PVector(-0.05, 0);
  PVector up = new PVector(0, -.05);
  PVector down = new PVector(0, .05);
  boolean goLeft, goRight, goUp, goDown;
  boolean shifted;
  boolean moving = false;
  float triMove = 0;


  boolean player;

  player() {
  }

  player(float x, float y) {
    mass = 1;
    posi = new PVector(width/2, height/2);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(30, 30);
    speed = 5;
    player = true;
  }

  //the the virus eats the player, then the game is over
  void ifDead(GameOver gameOver) {
    if (health <= 1) {
      gameOver.gameDone = true;
    }
  }
  //Apply the force of movement and mass of the player, since mass is not needed its set at 1
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    //We accelerate by adding the force to acceleration 
    accel.add(f);
  }

  void movement() {
    //Add accel to velocity
    velo.add(accel);
    //Add the position to the velo
    posi.add(velo);
    //Reset it so it doesnt add up too fast 
    accel.mult(0);
    //Limit it to the speed variable 
    velo.limit(speed);
    //If the lefy key is pressed then the backwards PVector is applied using the applyforce PVector
    //The same for all the other arrow keys 
    if (goLeft) {
      applyForce(backwards);
    } 
    if (goRight) {
      applyForce(forward);
    } 
    if (goUp) {
      applyForce(up);
    } 
    if (goDown) {
      applyForce(down);
    }
  }
  //You can also move the creatures areound with the player by holding shift and going over them 
  void moveLife(ArrayList<RegLife> rLife, ArrayList<smallLife> sLife, ArrayList<largeLife> lLife) {
    //Call the for loops for the creatures and specify their poistion and size
    //So if their position of the player and the creature is less than size X (the middle) then the creature can be dragged around 
    //The same for all the others
    for (int i = 0; i < rLife.size(); i++) {
      RegLife r = rLife.get(i);
      if (dist(posi.x, posi.y, r.posi.x, r.posi.y) < size.x/2) {
        if (shifted) {
          r.posi.x = posi.x;
          r.posi.y = posi.y;
        }
      }
    }
    for (int j = 0; j < sLife.size(); j++) {
      smallLife s = sLife.get(j);
      if (dist(posi.x, posi.y, s.posi.x, s.posi.y) < size.x/2) {
        if (shifted) {
          s.posi.x = posi.x;
          s.posi.y = posi.y;
        }
      }
    }
    for (int l = 0; l < lLife.size(); l++ ) {
      largeLife ls = lLife.get(l);
      if (dist(posi.x, posi.y, ls.posi.x, ls.posi.y) < size.x/2) {
        if (shifted) {
          ls.posi.x = posi.x;
          ls.posi.y = posi.y;
        }
      }
    }
  }

  void offScreen() {
    //If the position x is greater than 10 then bring it over to the other side
    if (posi.x > width+10 ) {
      posi.x = -10;
    } 
    //Opposite of above
    if (posi.x < -10) {
      posi.x = width;
    } 
    //same for y
    if (posi.y > height+10) {
      posi.y = -10;
    } 
    if (posi.y < -10) {
      posi.y = height;
    }
  }
  //Random sounds that the creatures will make
  //I attempted to create an array of sounds but my sounds were different files 
  //So I used a method which a different sound plays based on the number chosen at random 
  //Similar to the virus spawning 
  void randomSounds() {
    float rSoundBetween = floor(random(0, 3000));
    if (rSoundBetween == 18) {
      random1.play();
    }
    if ( rSoundBetween == 36) {
      random2.play();
    } 
    if (rSoundBetween == 100) {
      random3.play();
    } 
    if (rSoundBetween == 150) {
      random4.play();
    }
  }


  void display() {
    fill(0, 0, health);
    float mov = 20;
    //This checks if the player is moving in any direction 
    //If they are then a triangle will move up and down 
    if (goLeft||goRight||goUp||goDown) {
      moving = true;
    } else {
      moving = false;
    }
    if (moving) {
      if (triMove <= mov ) {
        triMove +=2;
      }
      if (triMove == mov) {
        triMove = -40;
      }
    }
    pushMatrix();
    //We use heading to calculate the rotational velocity, and add the radians of 90 since its a triangle 
    float t = velo.heading() + radians(90);  
    //translate the position from the position of the triange
    translate(posi.x, posi.y);
    strokeWeight(2);
    rotate(t);
    triangle(20, 10, 0, 10, 10, -30);
    triangle(20, -30+triMove, 0, -30+triMove, 10, -70+triMove);
    strokeWeight(1);
    line(10, 0, 10, -50+triMove);
    popMatrix();
  }
}