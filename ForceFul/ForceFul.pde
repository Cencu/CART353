//What I want to do: demonstrate the effects of various 
//Landscapes on a tire
//Ice - Hard to stop, hard to accel-DONE
//Tar - Very low speed
//Two stages M for magnesis, R for Road, M moves you up to experience the 
//Magnetic effect

//Our classes
Tire t;
Ice s;
Tar tr;
void setup() {
  size(1400, 800);
  t = new Tire();
  s = new Ice(300, 550);
  tr = new Tar(500, 750);
}


void draw() {
  background(255); 

  //  Ice.slip(tire);

  s.slip(t);
  s.display();

  tr.stick(t);
  tr.display();

  t.update();
  t.check();
  t.display();
  println(t.accel);
}