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


  
  
  
  
  
  
  
}