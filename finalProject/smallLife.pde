class smallLife {
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
  boolean placed = false;
  float moment;

  //Array of images used for the gif 
  PImage[] images;
  int imageCount;
  int frame;

  smallLife(String imagePrefix, float x, float y, int count) {
    posi = new PVector(x, y);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(30, 30);
    speed = .7;
    withinAura = false;
    placed = false;
    moment = 0;
    health = 400;
    //the image count equals the count
    imageCount = count;
    //create the array of images
    images = new PImage[imageCount];
    //use a for loop to go through all the images
    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      //use the string and change it to the prefix, which is the name of the files, add the numbers corresponding to the images also 
      //They go up by 0000 0001 etc... then add the .png
      //load the array of images
      String filename = imagePrefix + nf(i, 4) + ".png";
      images[i] = loadImage(filename);
    }
  }

  //basic movement
  void update() {
    if (health < 50 && health > 49) {
      lLifeHunger.play();
    } 
    health -= .02;
    if (health >= 5) {
      placed = true;
    } 
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
  boolean dead() {
    if (health < 1) {
      return true;
    } else {
      return false;
    }
  }
  void display() {
    fill(0);
    imageMode(CENTER);
    //the frames equal the frames +1, which is divided by the image count
    frame = (frame+1) % imageCount;
    //display the gif 
    image(images[frame], posi.x, posi.y, size.x, size.y); //CENTER
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
  //return the images
  int getWidth() {
    return images[0].width;
  }
}