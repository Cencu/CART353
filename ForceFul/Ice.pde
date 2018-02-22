class Ice {

  PVector posi;
  float grip = .0;
  float limit =2;


  Ice(float x, float y) {
    posi = new PVector(x, y);
    limit = 2;
  }



  void slip(Tire tire) {
    PVector icy = tire.velo.get();


    if (tire.posi.x >= 300 && tire.posi.x <= 550) {
      tire.applyForce(icy);
    } else {
      icy.mult(2);
      icy.normalize();
      icy.limit(2);
    }
  }



  void display() {
    fill(127);
    rect(300, 550, 250, 400);
  }
}