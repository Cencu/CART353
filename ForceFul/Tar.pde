class Tar {
  
  PVector posi;
  float grip = -.07;
  PImage tar;

  Tar(float x, float y) {
    posi = new PVector(x, y);
    tar = loadImage("tar.jpg");
  }

  void stick(Tire tire) {
    PVector sticky = tire.velo.get();
//Multiply the velocity by two, then normalize it then multiply it by the grip
    sticky.mult(2);
    sticky.normalize();
    sticky.mult(grip);
    //If the tire is within range, then the car will get stuck by applying the 
    //Force of the grip to the velocity
    if (tire.posi.x >= 650 && tire.posi.x <= 850 && tire.posi.y >= height-100) {
      tire.applyForce(sticky);
    }
  }

  void display() {
    fill(127);
    image(tar, 650, 750, 250, 50);
  }
}