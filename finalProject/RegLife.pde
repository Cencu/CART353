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
  float maxCreate;

  float health;
  //Call the array again to call objects in the class
  ArrayList<RegLife> rLife;
  float p;
  float mutation = 1;
  float theta = 0.0;

  RegLife(float x, float y) {
    posi = new PVector(x, y);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(30, 30);
    withinAura = false;
    placed = false;
    speed = 1;
    health = 500;
    maxCreate = 0;
  }
  //basic movement
  void update() {
    health-=.02;
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
}