class Ice {

  PVector posi;
  float grip = .03;
  float limit =2;


  Ice(float x, float y) {
    posi = new PVector(x, y);
    limit = 2;
  }



  void slip(Tire tire) {
    PVector icy = tire.velo.get();

    icy.mult(2);
    icy.normalize();
    icy.mult(grip);
    if (tire.posi.x >= 300 && tire.posi.x <= 550) {
      tire.applyForce(icy);
    } 
    icy.mult(2);
    icy.normalize();
    icy.mult(grip);
  }



  void display() {
    fill(127);
    rect(300, 550, 250, 400);
  }
}