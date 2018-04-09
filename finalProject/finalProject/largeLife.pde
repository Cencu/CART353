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

  boolean eating;
  boolean eatingS;
  ArrayList<RegLife> rLife;
  ArrayList<smallLife> sLife;

  PImage[] images;
  int imageCount;
  int frame;

  //create the object and specify its characteristics
  largeLife(String imagePrefix, float x, float y, int count) {
    posi = new PVector(x, y);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(60, 60);
    speed = 1;
    eating = false;
    eatingS = false;
    health = 100;

    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 4) + ".png";
      images[i] = loadImage(filename);
    }
  }



  //basic movement
  void update() {
    println(health);
    health -=.02;
    health = constrain(health, 0, 500);
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
    steer.limit(1);
    applyForce(steer);
  }


  void findFood(ArrayList<RegLife> rLife, ArrayList<smallLife> sLife, ArrayList<virus> v) {
    boolean foundSmall = false;
    boolean foundVirus= false;
    for (int i = 0; i < v.size(); i++) {
      virus vs =  v.get(0);
      if ( r == 1); 
      {
        foundVirus = true;
        speed = 4;
        break;
      }
    } 
    if (foundVirus) {
      for (int i = 0; i < v.size(); i++) {
        virus vs =  v.get(0);
        PVector desired = PVector.sub(vs.posi, posi);
        desired.setMag(speed);

        PVector steer = PVector.sub(desired, velo);
        applyForce(steer);
      }
    }
    for (int j = 0; j < sLife.size(); j++) {
      smallLife s = sLife.get(0);
      if (s.placed == true) {
        foundSmall = true;

        break;
      }
    }
    if  (foundSmall && !foundVirus) {
      speed =1;
      for (int j = 0; j < sLife.size(); j++) {
        smallLife s = sLife.get(0);
        PVector desired = PVector.sub(s.posi, posi);
        desired.setMag(speed);

        PVector steer = PVector.sub(desired, velo);
        applyForce(steer);
      }
    } 
    if (!foundSmall && !foundVirus) {
        speed = 1;
      for (int i = 0; i < rLife.size(); i++) {
        RegLife r = rLife.get(0);
        PVector desired = PVector.sub(r.posi, posi);
        desired.setMag(speed);
        PVector steer = PVector.sub(desired, velo);
        applyForce(steer);
      }
    }
  }


  PVector detection(ArrayList<RegLife> rLife) {
    //The PVector needs to return another PVector so
    //We create an empty one and return it at the end
    PVector sum = new PVector();

    //Cycle through each object
    for (int i = 0; i < rLife.size(); i++) {
      RegLife r = rLife.get(0);


      //distance between the object and another object
      float distb = PVector.dist(posi, r.posi);
      //Minimum distance is sizeX
      float minDist = r.size.x;
      //If the distance between the two objects is greater than 0
      //and the distance between the two objects is less than sizeX
      //Then the boolean becomes true
      if ((distb < r.posi.x) && (distb < minDist)) {
        eating = true;
      } else {
        eating = false;
      }
    }
    return sum;
  }
  PVector detectionV(ArrayList<virus> v) {
    //The PVector needs to return another PVector so
    //We create an empty one and return it at the end
    PVector sum = new PVector();

    //Cycle through each object
    for (int i = 0; i < v.size(); i++) {
      virus vs = v.get(0);


      //distance between the object and another object
      float distb = PVector.dist(posi, vs.posi);
      //Minimum distance is sizeX
      float minDist = vs.size.x;
      //If the distance between the two objects is greater than 0
      //and the distance between the two objects is less than sizeX
      //Then the boolean becomes true
      if ((distb < vs.posi.x) && (distb < minDist)) {
        eating = true;
      } else {
        eating = false;
      }
    }
    return sum;
  }
  void eatV(ArrayList<virus> v) {
    PVector eatV = detectionV(v);
    for (int i =v.size()-1; i >= 0; i--) {
      virus vs = v.get(0);
      if (eating == true) {
        vs.health--;
      } 
      if (vs.dead()) {
        v.remove(0);
        health += 100;
      } else {
        eating = false;
      }
    }
  }
  void eat(ArrayList<RegLife> rLife) {
    PVector eat = detection(rLife);
    for (int i = rLife.size()-1; i >= 0; i--) {
      RegLife r = rLife.get(0);

      if (eating == true) {
        r.health-=.04;
        health+=.03;
      } 
      if (r.dead()) {
        rLife.remove(0);
      } else {
        eating = false;
      }
    }
  }



  PVector detectionSmall(ArrayList<smallLife> sLife) {
    //The PVector needs to return another PVector so
    //We create an empty one and return it at the end
    PVector sum = new PVector();

    //Cycle through each object
    for (int j = sLife.size()-1; j >= 0; j--) {
      smallLife s = sLife.get(j);
      //distance between the object and another object
      float distbS = PVector.dist(posi, s.posi);
      //Minimum distance is sizeX
      float minDist = s.size.x;
      //If the distance between the two objects is greater than 0
      //and the distance between the two objects is less than sizeX
      //Then the boolean becomes true
      if ((distbS < s.posi.x) && (distbS < minDist)) {
        eatingS = true;
      } else {
        eatingS = false;
      }
    }
    return sum;
  }

  void eatSmall(ArrayList<smallLife> sLife) {
    PVector eatSmall = detectionSmall(sLife);
    for (int j = 0; j < sLife.size(); j++) {
      smallLife s = sLife.get(0);
      if (eatingS == true) {
        s.health-=.04;
        health += .03;
      } 
      if (s.dead()) {
        sLife.remove(j);
      } else {
        eatingS = false;
      }
    }
  }


  void display() {
    fill(0, health);
    //rectMode(CENTER);
    ellipse(posi.x-50, posi.y+50, size.x-30, size.y-30);//BOTTOM LEFT
    ellipse(posi.x+50, posi.y-50, size.x-30, size.y-30);//TOP RIGHT
    ellipse(posi.x-50, posi.y-50, size.x-30, size.y-30);//TOP LEFT
    ellipse(posi.x+50, posi.y+50, size.x-30, size.y-30);//BOTTOM RIGHT
    ellipse(posi.x+55, posi.y, size.x-30, size.y-30);//MIDDLE RIGHT
    ellipse(posi.x-55, posi.y, size.x-30, size.y-30);//MIDDLE RIGHT
    imageMode(CENTER);
    frame = (frame+1) % imageCount;

    image(images[frame], posi.x, posi.y, size.x+50, size.y); //CENTER
  }

  void moveLife() {
    if (dist(posi.x, posi.y, mouseX, mouseY) < size.x/2) {
      if (mousePressed) {
        posi.x = mouseX;
        posi.y = mouseY;
      }
    }
  }
  void offScreen() {
    if (posi.x > width+10 ) {
      posi.x = -10;
    } 
    if (posi.x < -10) {
      posi.x = width;
    } 
    if (posi.y > height+10) {
      posi.y = -10;
    } 
    if (posi.y < -10) {
      posi.y = height;
    }
  }
  int getWidth() {
    return images[0].width;
  }

  boolean dead() {
    if (health < 1) {
      return true;
    } else {
      return false;
    }
  }
  void died() {
    for (int l = 0; l < lLife.size(); l++ ) {
      largeLife lLives = lLife.get(l);
      if (dead()) {
        lLife.remove(l);
      }
    }
  }
}
