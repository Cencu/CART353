//What I want to do: demonstrate the effects of various 
//Landscapes on a tire
//Ice - Hard to stop, hard to accel
//Two stages M for magnesis, R for Road, M moves you up to experience the 
//Magnetic effect

//Our classes
Tire t;
Ice s;

void setup() {
  size(1400, 800);
  t = new Tire();
  s = new Ice(100, 200);
}


void draw() {
  background(255); 

  //  Ice.slip(tire);
 

  s.display();
  s.slip(t);

  t.update();
  t.display();
  println(t.accel);
}