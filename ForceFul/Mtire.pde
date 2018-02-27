class Mtire {
  PVector accel;
  PVector velo;
  PVector posi;
  float mass;
  float G;
  boolean withinRadi = false;

  Mtire(float m) {
    posi = new PVector(300, height/3);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    mass = m;
    G=5;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    accel.add(f);
  }

  PVector attract(Tire tire) {
    PVector force = PVector.sub(tire.posi, posi);
    float d = force.mag();
    d = constrain(d, 5, 10);
    force.normalize();
    float strenght = (G * tire.mass *mass) / (d*d);
    force.mult(strenght);
    return force;
  }

  void nearby(Tire tire) {
    if (posi.x < tire.posi.x -200 && posi.y == tire.posi.y) {
      withinRadi = true;
    } 
    if (withinRadi == true) {

      //PVector f = mt.attract(t);
      // mt.applyForce(f);
      posi.x = tire.posi.x-200;
      tire.mass = 3;
      mass = 3;
      posi.y = tire.posi.y;
    }
  }

  void update() {
    velo.add(accel);
    posi.add(velo);
    accel.mult(0);
  }

  void display() {
    stroke(2);
    fill(12, 17, 50);
    ellipse(posi.x, posi.y, 48, 48);
  }
}