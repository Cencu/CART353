class RegLife {
  //PVectors for location, velocity, acceleration and size
  PVector posi;
  PVector velo;
  PVector accel;
  PVector size;
  //Speed of the life forms
  float speed;
  //Wandering of the life form
  float wander;

  boolean withinAura;
  boolean placed;

  float health;
  //Call the array again to call objects in the class
  
  ArrayList<RegLife> rLife;
  float mutation = 1;
  float theta = 0.0;
  int created =0;

  RegLife(float x, float y) {
    posi = new PVector(x, y);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(30, 30);
    withinAura = false;
    placed = false;
    speed = 1;
    health = 200;
  }
  //basic movement
  void update() {
    //if the health gets low then the life form tells you its hungry
    //if the health is between 49 and 50 then it plays the sound
    if (health < 50 && health > 49) {
      lLifeHunger.play();
    } 
    //Health decreases at a constant rate
    health-=.04;
    //checks if the life form is placed
    if (health >= 5) {
      placed = true;
    } 
    //If the life form has really low health then it will be delted 
    if (health > 1 && health < 4) {
      placed = false;
    }
    //Add the acceleration to the velocity
    velo.add(accel);
    //limit the velocity to the speed limit
    velo.limit(speed);
    //add the position to the velocity
    posi.add(velo);
    //Reset it after each loop
    accel.mult(0);
  }

  void applyForce(PVector force) {
    accel.add(force);
  }

  //Create a wandering method, which makes it seem like the object wanders about on the screen
  void wander() {
    //Wander radius
    float wanderR = 25;
    //Changes the motion and how the life form moves 
    float wanderAmount = .05;
    //Get the velocity and attribute it to the "new" position
    PVector newPosi = velo.get();
    //Set it to one and multiply it by the speed
    newPosi.normalize();
    newPosi.mult(80);
    //Add the position
    newPosi.add(posi);
    //change in position while wandering
    wander += random(-wanderAmount, wanderAmount);
    //use heading to calculate the rotation for the velocity
    float h = velo.heading();

    //Create a new PVector adding these properties together
    //Use sin and cos to attribute non-linear movements
    //use heading and wander to attribute a random rotaion between the wander amound
    PVector wanderO = new PVector(wanderR*cos(wander+h), wanderR*sin(wander+h));
    //Create a target vector which adds the new position to the wander pvector
    PVector target = PVector.add(newPosi, wanderO);
    //apply seek to target
    seek(target);
  }
  //Add the target components to seek
  void seek(PVector target) {
    //desired is the PVector of the new position and the wandering effect
    //subtracted by the position to point to the target
    //Then set the scale to the speed
    PVector desired = PVector.sub(target, posi);
    desired.setMag(speed);
    //Steer uses the mock position to create a target in which the life form
    //Will follow using steer
    PVector steer = PVector.sub(desired, velo);
    steer.limit(.05);
    applyForce(steer);
  }

  PVector detection(ArrayList<RegLife> rLife) {
    //The PVector needs to return another PVector so
    //We create an empty one and return it at the end
    PVector empty = new PVector();

    //Cycle through each object
    for (RegLife r : rLife) {

      //distance between the object and another object
      //Of the same class
      float distb = PVector.dist(posi, r.posi);
      //Minimum distance is sizeX
      float minDist = size.x;
      //If the distance between the two objects is greater than 0
      //and the distance between the two objects is less than sizeX
      //Then the boolean becomes true
      if ((distb > 0) && (distb < minDist)) {
        withinAura = true;
      } else {
        withinAura = false;
      }
    }
    return empty;
  }

  //Use the arraylist again
  void createLife(ArrayList<RegLife> rLife) {
    //Call the PVector that detects the object
    PVector createLife = detection(rLife);
    //Checks if the player isnt forcibly grabbing the objects around to reproduce
    //has a random chance of mutation if the number returns less that 8
    if ( withinAura == true && mousePressed == false && random(mutation) <=.8) {
      rLife.add(new RegLife(random(width), random(height)));
      withinAura = false;
      created +=1;
      rLifeSpawn.play();
    } 
    
    if ( withinAura == true && mousePressed == false && random(mutation) <=.1) {
      lLife.add(new largeLife("lLife", random(width), random(height), 116));
      withinAura = false;
      largePlaced += 1;
      lLifespawn.play();
    } 
    if ( withinAura == true && mousePressed == false && random(mutation) <=.1) {
      sLife.add(new smallLife(random(width), random(height)));
      smallPlaced += 1;
    }
  }
//Use mouse to move the lives
  void moveLife() {
    if (dist(posi.x, posi.y, mouseX, mouseY) < size.x/2) {
      if (mousePressed) {
        posi.x = mouseX;
        posi.y = mouseY;
      }
    }
  }


//If the life has no more health than the boolean returns false and the life
//Gets removed
  boolean dead() {
    if (health < 1) {
      regPlaced-=1;
      return true;
    } else {
      return false;
    }
  }
//Checks if the lives wander off screen
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
//Checks how many lives that were reproduced have been created
  void addedLives() {
    textSize(10);
    //add the string of text, then NF is used to turn the name into an integer
    //Specifies how many numbers to return
    text("Regular Lives (Created)" + " "+ nf(created, 2), 70, 30);
  }

  void display() {
//checks the rotation of the velocity
    float t = velo.heading();  
    pushMatrix();
    //translate the positions
    translate(posi.x, posi.y);
    //rotate based on the heading
    rotate(t);
    //Since its a sprite we use the sprite library to call methods
    //setRot rotates the sprite
    //Set XY sets its position
    avatar.setRot(t);
    avatar.setXY(posi.x, posi.y);
    popMatrix();
    pushMatrix();
    //Translate the life forms legs
    translate(posi.x, posi.y);
    //rotate them so they look like they're moving side to side
    //rot chooses a random number which is multiplied by cos of theta, which is then multiplied by 10
    //the higher the number the faster the movement
    float rot = (random(cos(theta))*10);
    float rot2 = (random(cos(theta))*20);
    float rot3 = (random(cos(theta))*20);

    theta += 50;
    rotate(t);
    line(30, -20+rot, 20, -20);//TOP RIGHT 1
    //line(40, -30+rot, 20, -30);//TOP RIGHT 2
    line(30, -10+rot, 20, -10);//TOP RIGHT 3
    line(30, 0+rot, 15, 0);//MIDDLE
    line(30, 10+rot, 10, 10);//MIDDLE 2
    line(30, 20+rot, 5, 20);//BOTTOM
    line(30, 30+rot, 2, 30);//BOTTOM2
    //LEFT SIDE
    line(-10, -20, -30, -20+rot);//TOP LEFT
    line(-10, -10, -30, -10+rot);//TOP LEFT
    line(-10, 0, -30, 0+rot);//TOP LEFT 3
    line(-10, 10, -30, 10+rot);//MIDDLE
    line(-10, 20, -30, 20+rot);//MIDDLE 2
    line(-10, 30, -30, 30+rot);//BOTTOM
    //line(-10, 40, -30, 40+rot);//BOTTOM2

    //ANTENNAS
    line(-20-rot2, -60+rot2, 0, -35);//;EFT
    line(30+rot3, -60+rot3, 15, -35);//RIGHT
    popMatrix();
  }
}