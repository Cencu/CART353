class Car {

  PVector posi;
  PVector accel;
  PVector velo;
  float mass; 
  boolean withinRadi = false;
  PVector forward = new PVector(0.04, 0);
  PVector backwards = new PVector(-0.04, 0);
  PImage car;

  Car(float x, float y, float m) {
    posi =  new PVector(x, y);
    velo = new PVector(0, 0);
    accel = new PVector(0, 0);
    mass = 1;
    car = loadImage("car.png");
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass/2);
    accel.add(f);
  }



  void nearby(Tire tire) {
    if (posi.x < tire.posi.x -175 && posi. y == tire.posi.y-55) {
      withinRadi = true;
    } 
    if (withinRadi == true) {
      println(withinRadi);
      posi.x = tire.posi.x-110;
      posi.y = tire.posi.y-40;
    }
  }


  void update(Tire tire) {
    if (keyPressed && keyCode == RIGHT && withinRadi == true) {
      tire.applyForce(forward);
    } else if (keyPressed && keyCode == LEFT && withinRadi == true) {
      tire.applyForce(backwards);
    }
    velo.add(accel);
    posi.add(velo);
    accel.mult(0);
  }

  void display() {
    image(car, posi.x, posi.y, 175, 100);
  }
}