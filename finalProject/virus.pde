class virus {
  //PVectors for location, velocity, acceleration and size
  PVector posi;
  PVector velo;
  PVector accel;
  PVector size;

  //Speed of the life forms
  float speed;
  float health;
  boolean withinAura;
  boolean eating;

  PImage[] images;
  int imageCount;
  int frame;


  virus(String imagePrefix, float x, float y, int count) {
    posi = new PVector(x, y);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(20, 20);
    speed = 8;
    withinAura = false;
    health = 350;

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


  void findFood(ArrayList<RegLife> rLife, ArrayList<smallLife> sLife) {
    boolean foundReg = false;
    for (int i = 0; i < rLife.size(); i++) {
      RegLife r = rLife.get(0);
      if (r.placed) {
        foundReg = true;
        break;
      }
    } 
    if (foundReg) {
      for (int i = 0; i < rLife.size(); i++) {
        RegLife r = rLife.get(0);
        PVector desired = PVector.sub(r.posi, posi);
        desired.setMag(speed);

        PVector steer = PVector.sub(desired, velo);
        applyForce(steer);
      }
    } else {
      for (int j = 0; j < sLife.size(); j++) {
        smallLife s = sLife.get(0);
        PVector desired = PVector.sub(s.posi, posi);
        desired.setMag(speed);

        PVector steer = PVector.sub(desired, velo);
        applyForce(steer);
      }
    }
  }

  PVector detection(ArrayList<RegLife> rLife, ArrayList<smallLife> sLife) {
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
        eating = true;
      } else {
        eating = false;
      }
    }
    return sum;
  }

  void eat(ArrayList<RegLife> rLife, ArrayList<smallLife> sLife) {
    PVector eat = detection(rLife, sLife);
    for (int i = rLife.size()-1; i >= 0; i--) {
      RegLife r = rLife.get(0);
      if (eating == true) {
        r.health--;
        r.health--;
        r.health--;
        health+=.02;
      } 
      if (r.dead()) {
        rLife.remove(0);
      } else {
        eating = false;
      }
    }
  }

  void eatSmall(ArrayList<smallLife> sLife) {
    PVector eatSmall = detectionSmall(sLife);
    for (int j = 0; j < sLife.size(); j++) {
      smallLife s = sLife.get(0);
      if (eating == true) {
        s.health--;
        s.health--;
        s.health--;
        health+=.02;
      } 
      if (s.dead()) {
        sLife.remove(0);
      } else {
        eating = false;
      }
    }
  }

  void display() {
    fill(255, 0, 0, health);
    float t = velo.heading();
    pushMatrix();
    translate(posi.x,posi.y);
    rotate(t);
    triangle(-25, -40, -20, +10, 0, -10);
    triangle(25, -40, 0, -10, 20, 10);
    line(30, -50, 25, -37);
    line(-30, -50, -25, -37);
    frame = (frame+1) % imageCount;
    imageMode(CENTER);
    image(images[frame], 0, -50, size.x+40, size.y);
    popMatrix();
  }

  void moveLife() {
    if (dist(posi.x, posi.y, mouseX, mouseY) < size.x/2) {
      if (mousePressed) {
        posi.x = mouseX;
        posi.y = mouseY;
      }
    }
  }

  boolean dead() {

    if (health <= 0.0) {
      return true;
    } else {
      return false;
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
}