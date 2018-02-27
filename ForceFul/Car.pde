class Car {
  
  //PVectors of positions, speed and velocity
  PVector posi;
  PVector accel;
  PVector velo;
  //Weight of the car
  float mass; 
  //Check if the other tire is within the radius of the car
  boolean withinRadi = false;
  //Acceleration/deacceleration
  PVector forward = new PVector(0.04, 0);
  PVector backwards = new PVector(-0.04, 0);
  //Car image
  PImage car;


  Car(float x, float y, float m) {
    posi =  new PVector(x, y);
    velo = new PVector(0, 0);
    accel = new PVector(0, 0);
    mass = 1;
    car = loadImage("car.png");
  }

//Checks if the car is nearby
  void nearby(Tire tire) {
    if (posi.x < tire.posi.x -45 && posi. y == tire.posi.y-15) {
      withinRadi = true;
    } //If it is then the boolean becomes true and the car body starts to follow
    if (withinRadi == true) {
      posi.x = tire.posi.x-45;
      posi.y = tire.posi.y-15;
    }
  }

//When the boolean is true, the car starts to accelerate faster 
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
    imageMode(CENTER);
    image(car, posi.x, posi.y, 175, 100);
  }
}