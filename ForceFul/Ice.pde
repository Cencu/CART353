class Ice {

  PVector posi;
  float grip = .5;

  Ice(float x, float y) {
    posi = new PVector(x, y);
  }

  void slip(Tire tire) {
    PVector icy = tire.velo.get();
    icy.mult(2);
    icy.normalize();
    icy.mult(grip);
    
    if (tire.posi.x >= 100 && tire.posi.x <= 250) {
     tire.applyForce(icy);
    }
    
  }
  void display() {
    fill(127);
   rect(100,600,150,200); 
  }
}