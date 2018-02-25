class Mtire {
  
  PVector posi;
  
  
  
  Mtire() {
       posi = new PVector(300, height/3);
     
  }
  
  void buildOn(Tire tire) {
    if (posi.x == tire.posi.x ) {
      posi.x = tire.posi.x;
      println(true);
    }
    
  }
  
  
   void display() {
    stroke(2);
    fill(12, 17, 50);
    ellipse(posi.x, posi.y, 48, 48);
  }
  
  
}
  