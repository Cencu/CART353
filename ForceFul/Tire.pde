class Tire {

  //Three movement PVectors used to accelerate, calculate velocity and position
  PVector accel;
  PVector velo;
  PVector posi;

  float limit;


  Tire() {
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

  void accel(int a) {
    if (a == 0) {
      accel = new PVector(0, 0);
    } else if (a == 1) {
      accel = new PVector(0.01, 0);
    } else if(a == -1) {
      accel = new PVector(-.01, 0);
    } 
  }
 

  void display() {
    stroke(2);
    ellipse(posi.x, posi.y, 48, 48);
  }
}