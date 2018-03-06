class largeLife {

  //PVectors for location, velocity, acceleration and size
  PVector posi;
  PVector velo;
  PVector accel;
  PVector size;

  //Speed of the life forms
  float speed;
  //Wandering of the life form
  float wander;

  float health;

  boolean withinAura;


  //create the object and specify its characteristics
  largeLife(float x, float y) {
    posi = new PVector(x, y);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(60, 60);
    speed = .7;
    withinAura = false;
    health = 50;
  }

  //basic movement
  void update() {
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

  void findFood(ArrayList<RegLife> rLife) {
      for (RegLife r : rLife) {

      PVector desired = PVector.sub(r.posi, posi);
      desired.setMag(speed);

      PVector steer = PVector.sub(desired, velo);
      applyForce(steer);
      }
    }
    PVector detection(ArrayList<RegLife> rLife) {
      //The PVector needs to return another PVector so
      //We create an empty one and return it at the end
      PVector sum = new PVector();

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
        if ((distb < r.posi.x) && (distb < minDist)) {
          withinAura = true;
          println(withinAura);
        }
      
    }
      return sum;
    }

    void eat(ArrayList<RegLife> rLife) {
      PVector eat = detection(rLife);
      if (withinAura == true) {
        for (RegLife r : rLife) {
          r.health--;
        }
      }
    }

    void display() {
      fill(0, health);
      //rectMode(CENTER);
      ellipse(posi.x, posi.y, size.x, size.y);
    }

    void moveLife() {
      if (dist(posi.x, posi.y, mouseX, mouseY) < size.x/2) {
        if (mousePressed) {
          posi.x = mouseX;
          posi.y = mouseY;
        }
      }
    }
  }