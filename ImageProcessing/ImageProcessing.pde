//What I want to do
/*Create a box that changes opacity to reveal second picture
 On click the opacity box can be turned off
 the space bar can spraypaint the pictures a light random color based on mouse location */

PImage img;
  float spraySize = 50;


ImageOne picture;
ImageTwo picture2;
ArrayList<sprayPaint> sprayPaints;

void setup() {
  size(640, 280); 

  picture = new ImageOne(0, 0);
  picture2 = new ImageTwo(0, 0);
  sprayPaints = new ArrayList<sprayPaint>();
}

void draw() {
  background(255); 
  picture2.display();
  picture2.sprayPaint();

  picture.display();
  picture.dispRect();
  picture.imageOpac();
  for (int i = sprayPaints.size() -1; i >= 0; i--) {
   sprayPaint sprayPaint = sprayPaints.get(i); 
    sprayPaint.display();
    
  }

}

void keyPressed() {
 if (key == ' ') {
  sprayPaints.add(new sprayPaint(mouseX, mouseY, spraySize)); 
 }
  
}