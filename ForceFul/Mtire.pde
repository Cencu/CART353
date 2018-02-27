class Mtire {
  
  PVector accel;
  PVector velo;
  PVector posi;
  float mass;
  float G;
  PImage tire;
  boolean withinRadi = false;

  Mtire(float m) {
    posi = new PVector(300, height/3);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    mass = m;
    G=5;
    tire = loadImage("tire.png");
  }
//Checks if the tire is nearby
  void nearby(Tire tire) {
    if (posi.x < tire.posi.x -90 && posi.y == tire.posi.y) {
      withinRadi = true;
    } //If it is then this tire changes position
    //Its mass increases, making the acceleration harder
    if (withinRadi == true) {

      posi.x = tire.posi.x-90;
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
    image(tire, posi.x, posi.y, 48, 48);
  }
}