//Forceful-Car assembly
//Tire only-runs at a regular speed and mass
//Two tires, slower acceleration, higher mass (no engine!)
//car body- Engine included! car accelerates faster
//Ice and tar, one land you slide and  one you slow down and can get stuck in


//Classes
Tire t;
Mtire mt;
Ice s;
Tar tr;
Car c;

void setup() {
  //Call all the classes
  size(1400, 800);
  t = new Tire();
  mt = new Mtire(1);
  s = new Ice(300, 550);
  tr = new Tar(500, 750);
  c = new Car(800, height/3-55, 1);
}


void draw() {
  background(255); 

  s.slip(t);
  s.display();

  tr.stick(t);
  tr.display();

  mt.nearby(t);
  mt.update();
  mt.display();

  t.update();
  t.check();
  t.upstairs();
  t.display();

  c.update(t);
  c.nearby(t);
  c.display();
}