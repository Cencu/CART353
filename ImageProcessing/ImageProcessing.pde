//What I want to do
/*Create a box that changes opacity to reveal second picture
 On click the opacity box can be turned off
 the space bar can spraypaint the pictures a light random color based on mouse location */




ImageOne picture;
ImageTwo picture2;

void setup() {
  size(640, 280); 

  picture = new ImageOne(0, 0);
  picture2 = new ImageTwo(0, 0);
}

void draw() {
  background(255); 
  picture2.display();
  picture2.sprayPaint();

  picture.display();
  picture.dispRect();
  picture.imageOpac();

}