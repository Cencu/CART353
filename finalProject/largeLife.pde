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
  //Health
  float health;
  //A method to check what the life is eating
  boolean eating;
  //Checks if its eating small lives
  boolean eatingS;
  //Call the arrays to edit them
  ArrayList<RegLife> rLife;
  ArrayList<smallLife> sLife;
  //Array of images used for the gif 
  PImage[] images;
  int imageCount;
  int frame;

  //create the object and specify its characteristics
  //the name of the images in the data folder, excluding the .png
  largeLife(String imagePrefix, float x, float y, int count) {
    posi = new PVector(x, y);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(60, 60);
    speed = 1;
    eating = false;
    eatingS = false;
    health = 100;
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
    //health decreases at a constant rate
    health -=.02;
    //constrain the health so that when eating other things the life form doesnt become invincible 
    health = constrain(health, 0, 300);
    //If the health is between 50 and 49 then it will play a tone to show its hunger
    if (health < 50 && health > 49) {
      lLifeHunger.play();
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
    //desired is the PVector of the position and the wandering effect
    //subtracted by the position to point to the target
    //Then set the magnitude to the speed
    PVector desired = PVector.sub(target, posi);
    desired.setMag(speed);
    //Steer uses the position to create a target in which the life form
    //Will follow using steer
    PVector steer = PVector.sub(desired, velo);
    steer.limit(1);
    applyForce(steer);
  }


  void findFood(ArrayList<RegLife> rLife, ArrayList<smallLife> sLife, ArrayList<virus> v) {
    //If there is no other life forms on the screen it will not search for them
    boolean foundSmall = false;
    boolean foundVirus= false;
    //create a for loop to go through the array of viruses
    for (int i = 0; i < v.size(); i++) {
      virus vs =  v.get(0);
      //If R = one, like the method to spawn them in, then found virus is true 
      //The boolean turns true and the speed increases
      if ( r == 1); 
      {
        foundVirus = true;
        speed = 4;
        //Break out of the for loop
        break;
      }
    } 
    if (foundVirus) {
      //When found virus is true we then go through another loop
      for (int i = 0; i < v.size(); i++) {
        virus vs =  v.get(0);
        //We call the PVectors to seek the position of the first virus placed
        PVector desired = PVector.sub(vs.posi, posi);
        desired.setMag(speed);
        //Steer subtracts both positions by the velocity and applys the force
        PVector steer = PVector.sub(desired, velo);
        applyForce(steer);
      }
    }//If its not true then we check if a small life form is placed, again by looping through each particle
    for (int j = 0; j < sLife.size(); j++) {
      smallLife s = sLife.get(0);
      if (s.placed == true) {
        foundSmall = true;
        //If it is true then we again break out of the loop
        break;
      }
    } //If a small life form is placed but not a virus, then we target the small lives using the same methods as above
    if  (foundSmall && !foundVirus) {
      //reset the speed after the virus is gone
      speed =1;
      //go through another loop
      for (int j = 0; j < sLife.size(); j++) {
        smallLife s = sLife.get(0);
        //get the position again and go towards it
        PVector desired = PVector.sub(s.posi, posi);
        desired.setMag(speed);

        PVector steer = PVector.sub(desired, velo);
        applyForce(steer);
      }
    } //Lastly, if both small lives and viruses are not on the screen, then we search for the regular lives
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

  //a method for detecting if we can start eating lives
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
    }//return the pvector
    return sum;
  }//do the same as above for viruses
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
  }//method for eating viruses
  void eatV(ArrayList<virus> v) {
    PVector eatV = detectionV(v);
    for (int i =v.size()-1; i >= 0; i--) {
      virus vs = v.get(0);
      //eating becomes true if the PVector detection is true
      //If the eating boolean from above is true
      if (eating == true) {
        //then the viruses health depletes
        vs.health--;
      } 
      //If the virus is dead then we remove it, the large life gains a surge of health
      if (vs.dead()) {
        v.remove(0);
        health += 100;
        lLifeAlert.play();
        virusSpawn.stop();
      } else {
        eating = false;
      }
    }
  }//Same method as above
  void eat(ArrayList<RegLife> rLife) {
    //We detect if the life form is within its radius 
    PVector eat = detection(rLife);
    for (int i = rLife.size()-1; i >= 0; i--) {
      RegLife r = rLife.get(0);
      //If it is then eating is true and the health of the rLife depletes and the large one goes up
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
        sLifedead.play();
      } else {
        eatingS = false;
      }
    }
  }


  void display() {
    fill(0, health);
    ellipse(posi.x-50, posi.y+50, size.x-30, size.y-30);//BOTTOM LEFT
    ellipse(posi.x+50, posi.y-50, size.x-30, size.y-30);//TOP RIGHT
    ellipse(posi.x-50, posi.y-50, size.x-30, size.y-30);//TOP LEFT
    ellipse(posi.x+50, posi.y+50, size.x-30, size.y-30);//BOTTOM RIGHT
    ellipse(posi.x+55, posi.y, size.x-30, size.y-30);//MIDDLE RIGHT
    ellipse(posi.x-55, posi.y, size.x-30, size.y-30);//MIDDLE RIGHT
    imageMode(CENTER);
    //the frames equal the frames +1, which is divided by the image count
    frame = (frame+1) % imageCount;
    //display the gif 
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
  //return the images
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
        lLifedeplete.play();
      }
    }
  }
}