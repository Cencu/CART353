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
    speed = 4;
    withinAura = false;
    health = 300;
  }

  
  
  
  
  
  
  
  
  
}