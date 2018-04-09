class RegLife {
  //PVectors for location, velocity, acceleration and size
  PVector posi;
  PVector velo;
  PVector accel;
  PVector size;
  PVector eliS = new PVector(30, 30);
  //Speed of the life forms
  float speed;
  //Wandering of the life form
  float wander;

  boolean withinAura;
  boolean placed;

  float health;
  //Call the array again to call objects in the class
  ArrayList<RegLife> rLife;
  float p;
  float mutation = 1;
  float theta = 0.0;
  int created =0;

  PImage bacteria;


  RegLife(float x, float y) {
    posi = new PVector(x, y);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(30, 30);
    withinAura = false;
    placed = false;
    speed = 1;
    health = 200;
    // bacteria = loadImage("reglife.png");
  }
  //basic movement
  void update() {
    //println(health);
    health-=.02;
    if (health >= 5) {
      placed = true;
    } 
    if (health > 1 && health < 4) {
      placed = false;
    }
    //Add the acceleration to the velocity
    velo.add(accel);
    //limit the velocity to the speed limit
    velo.limit(speed);
    //add the position to the velocity
    posi.add(velo);
    //Reset it after each loop
    accel.mult(0);
  }

  void applyForce(PVector force) {
    accel.add(force);
  }

  //Create a wandering method, which makes it seem like the object wanders about on the screen
  void wander() {
    //Wander radius
    float wanderR = 25;
    //Changes the motion and how the life form moves 
    float wanderAmount = .05;
    //Get the velocity and attribute it to the "new" position
    PVector newPosi = velo.get();
    //Set it to one and multiply it by the speed
    newPosi.normalize();
    newPosi.mult(80);
    //Add the position
    newPosi.add(posi);
    //change in position while wandering
    wander += random(-wanderAmount, wanderAmount);
    //use heading to calculate the rotation for the velocity
    float h = velo.heading();

    //Create a new PVector adding these properties together
    //Use sin and cos to attribute non-linear movements
    //use heading and wander to attribute a random rotaion between the wander amound
    PVector wanderO = new PVector(wanderR*cos(wander+h), wanderR*sin(wander+h));
    //Create a target vector which adds the new position to the wander pvector
    PVector target = PVector.add(newPosi, wanderO);
    //apply seek to target
    seek(target);
  }
  //Add the target components to seek
  void seek(PVector target) {
    //desired is the PVector of the new position and the wandering effect
    //subtracted by the position to point to the target
    //Then set the scale to the speed
    PVector desired = PVector.sub(target, posi);
    desired.setMag(speed);
    //Steer uses the mock position to create a target in which the life form
    //Will follow using steer
    PVector steer = PVector.sub(desired, velo);
    steer.limit(.05);
    applyForce(steer);
  }

  void boundingBox() {
    //Create a radius for the box that the life form
    //Will be kept in
    PVector radi = new PVector(450, 450); 
    //Create an empty PVector
    PVector newPosi = null;

    //Checks all four sides and checks to see if the life form is touching any side
    //If it is then it adjusts the direction by creating a new PVector
    //With its speed and velocity changing
    if (posi.x < radi.x) {
      newPosi = new PVector(speed, velo.y);
    } else if (posi.x > width-radi.x) {
      newPosi = new PVector(-speed, velo.y);
    } 
    if (posi.y < radi.y) {
      newPosi = new PVector(velo.x, speed);
    } else if (posi.y > height-radi.y) {
      newPosi = new PVector(velo.x, -speed);
    }
    //If the new position PVector is not true, then continue as normal
    if (newPosi != null) {

      newPosi.normalize();
      newPosi.mult(speed);
      PVector steer = PVector.sub(newPosi, velo);
      steer.limit(speed);
      applyForce(steer);
    }
    noFill();
    rect(radi.x, radi.y, width-450*2, height-450*2);
  }

  PVector detection(ArrayList<RegLife> rLife) {
    //The PVector needs to return another PVector so
    //We create an empty one and return it at the end
    PVector empty = new PVector();

    //Cycle through each object
    for (RegLife r : rLife) {

      //distance between the object and another object
      //Of the same class
      float distb = PVector.dist(posi, r.posi);
      //Minimum distance is sizeX
      float minDist = size.x;
      //If the distance between the two objects is greater than 0
      //and the distance between the two objects is less than sizeX
      //Then the boolean becomes true
      if ((distb > 0) && (distb < minDist)) {
        withinAura = true;
      } else {
        withinAura = false;
      }
    }
    return empty;
  }

  //Use the arraylist again
  void createLife(ArrayList<RegLife> rLife) {
    //Call the PVector that detects the object
    PVector createLife = detection(rLife);
    if ( withinAura == true && mousePressed == false && random(mutation) <=.8) {
      rLife.add(new RegLife(random(width), random(height)));
      withinAura = false;
      created +=1;
      eliS.x = 0;
      eliS.y = 0;
    } 
    if ( withinAura == true && mousePressed == false && random(mutation) <=.1) {
      lLife.add(new largeLife("lLife", random(width), random(height), 116));
      withinAura = false;
      eliS.x = 0;
      eliS.y = 0;
      largePlaced += 1;
    } 
    if ( withinAura == true && mousePressed == false && random(mutation) <=.1) {
      sLife.add(new smallLife(random(width), random(height)));
      eliS.x = 0;
      eliS.y = 0;
      smallPlaced += 1;
    }
  }

  void moveLife() {
    if (dist(posi.x, posi.y, mouseX, mouseY) < size.x/2) {
      if (mousePressed) {
        posi.x = mouseX;
        posi.y = mouseY;
      }
    }
  }



  boolean dead() {

    if (health < 1) {
      regPlaced-=1;

      return true;
    } else {
      return false;
    }
  }

  void runFromVirus(ArrayList<virus> v) {
    for (int i = 0; i < v.size(); i++) {
      virus vr = v.get(i);


      PVector desired = PVector.sub(posi, vr.posi);
      desired.setMag(speed);

      PVector steer = PVector.sub(desired, velo);
      applyForce(steer);
    }
  }

  void offScreen() {
    if (posi.x > width+10 ) {
      posi.x = -10;
    } 
    if (posi.x < -10) {
      posi.x = width;
    } 
    if (posi.y > height+10) {
      posi.y = -10;
    } 
    if (posi.y < -10) {
      posi.y = height;
    }
  }

  void display() {

    float t = velo.heading();
    println(t);
    noStroke();
    fill(127);
    rectMode(CENTER);    
    imageMode(CENTER);
    stroke(2);  
    pushMatrix();
    translate(posi.x,posi.y);

    float rot = (random(cos(theta))*10);
    float rot2 = (random(cos(theta))*20);
    float rot3 = (random(cos(theta))*20);

    theta += 50;
    rotate(t);
    line(40, 10+rot, 30, 10);//TOP RIGHT
    line(40, 20+rot, 30, 20);//TOP RIGHT 2
    line(40, 30+rot, 30, 30);//TOP RIGHT 3
    line(posi.x+40, posi.y+40+rot, posi.x+30, posi.y+40);//MIDDLE
    line(posi.x+40, posi.y+50+rot, posi.x+30, posi.y+50);//MIDDLE 2
    line(posi.x+40, posi.y+60+rot, posi.x+30, posi.y+60);//BOTTOM
    line(posi.x+40, posi.y+70+rot, posi.x+30, posi.y+70);//BOTTOM2
    //LEFT SIDE
    line(posi.x, posi.y+10, posi.x-10, posi.y+10+rot);//TOP LEFT
    line(posi.x, posi.y+20, posi.x-10, posi.y+20+rot);//TOP LEFT
    line(posi.x, posi.y+30, posi.x-10, posi.y+30+rot);//TOP LEFT 3
    line(posi.x, posi.y+40, posi.x-10, posi.y+40+rot);//MIDDLE
    line(posi.x, posi.y+50, posi.x-10, posi.y+50+rot);//MIDDLE 2
    line(posi.x, posi.y+60, posi.x-10, posi.y+60+rot);//BOTTOM
    line(posi.x, posi.y+70, posi.x-10, posi.y+70+rot);//BOTTOM2

    //ANTENNAS
    line(posi.x-10-rot2, posi.y-20+rot2, posi.x+10, posi.y+2);//;EFT
    line(posi.x+40+rot3, posi.y-20+rot3, posi.x+20, posi.y+2);//RIGHT
    popMatrix();
    pushMatrix();
    translate(posi.x, posi.y);
    rotate(t);
    //rect(posi.x, posi.y, size.x, size.y+50, 30, 30, 30, 30);

    avatar.setRot(t);
    avatar.setXY(posi.x, posi.y);

    popMatrix();
    // avatar
    stroke(1);
    ellipse(posi.x, posi.y, eliS.x, eliS.y);
  }
}