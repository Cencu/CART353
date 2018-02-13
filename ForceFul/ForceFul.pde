//What I want to do: demonstrate the effects of various 
//Landscapes on a tire
//Ice - Hard to stop, hard to accel

//Our Tire class
Tire t;

void setup() {
  size(1400,800);
  t = new Tire();
}


void draw() {
 background(255); 
  
  if(keyPressed && keyCode == RIGHT) {
    t.accel(1);
  } else if(keyPressed && keyCode ==LEFT) {
    t.accel(-1);
  } else {
    t.accel(0);
  }
  t.update();
  t.display();
      println(t.accel);

}