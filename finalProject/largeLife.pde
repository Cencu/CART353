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
  
  
  
  
  
  
  
  
  
}