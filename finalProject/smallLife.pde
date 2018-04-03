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

  smallLife(float x, float y) {
    posi = new PVector(x, y);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(20, 20);
    speed = .7;
    withinAura = false;
    placed = false;
    moment = 0;
    health = 600;
  }
  
   //basic movement
  void update() {
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

  
  
  
  
  
  
  
  
  
  
  
  
}