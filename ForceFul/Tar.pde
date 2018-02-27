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

    sticky.mult(2);
    sticky.normalize();
    sticky.mult(grip);
    if (tire.posi.x >= 650 && tire.posi.x <= 850 && tire.posi.y >= height-100) {
      tire.applyForce(sticky);
    }
  }

  void display() {
    fill(127);
    image(tar,650, 750, 250, 50);
  }
}