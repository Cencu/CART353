//What I want to do: demonstrate the effects of various 
//Landscapes on a tire
//Ice - Hard to stop, hard to accel-DONE
//Tar - Very low speed-DONE
//
//Two stages M for magnesis, R for Road, M moves you up to experience the 
//Magnetic effect
//Tire and car on top, magnesis transforms the tire into a full car 


//Our classes
Tire t;
Mtire mt;
Ice s;
Tar tr;
Car c;
void setup() {
  size(1400, 800);
  t = new Tire();
  mt = new Mtire(1);
  s = new Ice(300, 550);
  tr = new Tar(500, 750);
  c = new Car(800, height/3, 1);
}


void draw() {
  background(255); 

  //  Ice.slip(tire);

  s.slip(t);
  s.display();

  tr.stick(t);
  tr.display();
  mt.nearby(t);
  // PVector f = mt.attract(t);
  mt.update();
  //mt.applyForce(f);
  mt.display();

  c.update(t);
  c.nearby(t);
  c.display();
  
  t.update();
  t.check();
  t.upstairs();
  t.display();
}