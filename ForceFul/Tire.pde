class Tire {

  //Three movement PVectors used to accelerate, calculate velocity and position
  PVector accel;
  PVector velo;
  PVector posi;
  float mass;
  float limit;
  PVector forward = new PVector(0.02, 0);
  PVector backwards = new PVector(-0.02, 0);
  PImage tire;
  
  Tire() {
    mass = 1;
    posi = new PVector(40, height-50);
    velo = new PVector(0, 0);
    accel = new PVector(0, 0);
    limit = 10;
    tire = loadImage("tire.png");
  }

  void upstairs() {
    if (keyCode == 'm' || keyCode == 'M') {
      posi.y = height/3;
      posi.x = 40;
    } else if (keyCode == 'd' || keyCode == 'D') {
      posi.y = height-40;
      posi.x = 40;
    }
  }


  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    accel.add(f);
  }

  void update() {
    if (keyPressed && keyCode == RIGHT) {
      applyForce(forward);
   
    } else if (keyPressed && keyCode == LEFT) {
      applyForce(backwards);
    }
    velo.add(accel);
    posi.add(velo);
    accel.mult(0);
    velo.limit(limit);
    println(velo);
  }

  void display() {
    stroke(2);
    fill(12, 17, 50);
    image(tire,posi.x, posi.y, 48, 48);
  }

  void check() {

    if (posi.x > width) {
      posi.x = 0;
    } else if (posi.x < 0) {
      posi.x = width;
    }

    if (posi.y > height) {
      velo.y *= -1;
      velo.y = height;
    }
  }
}