//What I want to do
/*Create a box that changes opacity to reveal second picture
On click the opacity box can be turned off
the space bar can spraypaint the pictures a light random color based on mouse location */




PImage img2;
ImageOne picture;

void setup() {
 size(640, 280); 

    picture = new ImageOne(0,0);
  
}

void draw() {
 background(255); 
  picture.display();
  picture.dispRect();

}