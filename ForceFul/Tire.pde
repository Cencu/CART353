class Tire {

  //Three movement PVectors used to accelerate, calculate velocity and position
  PVector accel;
  PVector velo;
  PVector posi;
  float mass;
  float limit;


  Tire() {
    mass = mass;
    posi = new PVector(28, height-55);
    velo = new PVector(0, 0);
    accel = new PVector(0, 0);
    limit = 10;
  }

  void update() {
    velo.add(accel);
    posi.add(velo);
    velo.limit(limit);
  }

  void accel() {
    //if (a == 0) {
    //  accel = new PVector(0, 0);
    //} else if (a == 1) {
    //  accel = new PVector(0.01, 0);
    //} else if(a == -1) {
    //  accel = new PVector(-.01, 0);
    //} 
    velo.add(accel);
    posi.add(velo);
    accel.mult(0);
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    accel.add(f);
  }
 

  void display() {
    stroke(2);
    fill(12,17,50);
    ellipse(posi.x, posi.y, 48, 48);
  }
}