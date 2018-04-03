class RegLife {
  //PVectors for location, velocity, acceleration and size
  PVector posi;
  PVector velo;
  PVector accel;
  PVector size;

  //Speed of the life forms
  float speed;
  //Wandering of the life form
  float wander;

  boolean withinAura;
  boolean placed;
  float maxCreate;

  float health;
  //Call the array again to call objects in the class
  ArrayList<RegLife> rLife;
  float p;
  float mutation = 1;
  float theta = 0.0;

  RegLife(float x, float y) {
    posi = new PVector(x, y);
    accel = new PVector(0, 0);
    velo = new PVector(0, 0);
    size = new PVector(30, 30);
    withinAura = false;
    placed = false;
    speed = 1;
    health = 500;
    maxCreate = 0;
  }
  //basic movement
  void update() {
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
  
}