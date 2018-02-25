class Ice {

  PVector posi;
  float grip = .029;
  float limit;


  Ice(float x, float y) {
    posi = new PVector(x, y);
    limit = 1;
  }



  void slip(Tire tire) {
    PVector icy = tire.velo.get();

    icy.mult(2);
    icy.normalize();
    icy.mult(grip);
    if (tire.posi.x >= 300 && tire.posi.x <= 550 && tire.posi.y >= height-100) {
      tire.applyForce(icy);
    } 
 
  }



  void display() {
    fill(127);
    rect(300, 500, 250, 400);
  }
}