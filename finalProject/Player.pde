class player {

  //PVectors for location, velocity, acceleration and size
  PVector posi;
  PVector velo;
  PVector accel;
  PVector size;
  //Speed of the life forms
  float speed;
  float mass;
  float health = 255;

  PVector forward = new PVector(0.05, 0);
  PVector backwards = new PVector(-0.05, 0);
  PVector up = new PVector(0, -.05);
  PVector down = new PVector(0, .05);
  boolean goLeft, goRight, goUp, goDown;
  boolean shifted;
  boolean moving = false;
  float triMove = 0;

  boolean player;

  player(float x, float y) {
    mass = 1;
    posi = new PVector(width/2, height/2);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(30, 30);
    speed = 5;
    player = true;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    accel.add(f);
  }

  void movement() {
    velo.add(accel);
    posi.add(velo);
    accel.mult(0);
    velo.limit(speed);
    if (goLeft) {
      applyForce(backwards);
    } 
    if (goRight) {
      applyForce(forward);
    } 
    if (goUp) {
      applyForce(up);
    } 
    if (goDown) {
      applyForce(down);
    }
  }
  void moveLife(ArrayList<RegLife> rLife, ArrayList<smallLife> sLife, ArrayList<largeLife> lLife) {
    for (int i = 0; i < rLife.size(); i++) {
      RegLife r = rLife.get(i);
      if (dist(posi.x, posi.y, r.posi.x, r.posi.y) < size.x/2) {
        if (shifted) {
          r.posi.x = posi.x;
          r.posi.y = posi.y;
        }
      }
    }
    for (int j = 0; j < sLife.size(); j++) {
      smallLife s = sLife.get(j);
      if (dist(posi.x, posi.y, s.posi.x, s.posi.y) < size.x/2) {
        if (shifted) {
          s.posi.x = posi.x;
          s.posi.y = posi.y;
        }
      }
    }
    for (int l = 0; l < lLife.size(); l++ ) {
      largeLife ls = lLife.get(l);
      if (dist(posi.x, posi.y, ls.posi.x, ls.posi.y) < size.x/2) {
        if (shifted) {
          ls.posi.x = posi.x;
          ls.posi.y = posi.y;
        }
      }
    }
  }

  void offScreen() {
    //If the position x is greater than 10 then bring it over to the other side
    if (posi.x > width+10 ) {
      posi.x = -10;
    } 
    //Opposite of above
    if (posi.x < -10) {
      posi.x = width;
    } 
    //same for y
    if (posi.y > height+10) {
      posi.y = -10;
    } 
    if (posi.y < -10) {
      posi.y = height;
    }
  }
  
  void display() {
    fill(0, 0, health);
    float mov = 20;
    if (goLeft||goRight||goUp||goDown) {
      moving = true;
    } 
    if (moving) {
      if (triMove <= mov ) {
        triMove +=2;
      }
      if (triMove == mov) {
        triMove = -40;
      }
    }
    pushMatrix();
    float t = velo.heading() + radians(90);  

    translate(posi.x, posi.y);
    strokeWeight(0);
    rotate(t);
    triangle(20, 10, 0, 10, 10, -30);
    triangle(20, -30+triMove, 0, -30+triMove, 10, -70+triMove);
    strokeWeight(1);
    line(9, 0, 9, -50+triMove);
    popMatrix();
  }
}