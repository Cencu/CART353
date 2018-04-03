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
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}