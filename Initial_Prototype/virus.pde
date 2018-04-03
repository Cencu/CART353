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


  virus(float x, float y) {
    posi = new PVector(x, y);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(20, 20);
    speed = 2;
    withinAura = false;
    health = 500;
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

  void findFood(ArrayList<RegLife> rLife) {
    for (int i = 0; i < rLife.size(); i++) {
      RegLife r = rLife.get(i);
          PVector desired = PVector.sub(r.posi, posi);
          desired.setMag(speed);

          PVector steer = PVector.sub(desired, velo);
          applyForce(steer);
        }
      }



  PVector detection(ArrayList<RegLife> rLife, ArrayList<smallLife> sLife) {
    //The PVector needs to return another PVector so
    //We create an empty one and return it at the end
    PVector sum = new PVector();

    //Cycle through each object
    for (int i = rLife.size()-1; i >= 0; i--) {
      RegLife r = rLife.get(i);


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

  void eat(ArrayList<RegLife> rLife) {
    PVector eat = detection(rLife, sLife);
    for (int i = rLife.size()-1; i >= 0; i--) {
      RegLife r = rLife.get(i);
      if (eating == true) {
        r.health--;
      } 
      if (r.dead()) {
        rLife.remove(i);
      } else {
        eating = false;
      }
    }
  }
  

  
    void display() {
      fill(255,0,0, health);
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

    boolean dead() {

    if (health <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
  
}