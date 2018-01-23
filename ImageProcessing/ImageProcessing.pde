/*Left and right click to change alpha
Spacebar to add spraypaints
Mouse movement detects different colors based on image color
S to sav */

PImage img;
float spraySize = 50;
int j = 0;

//Images Used
ImageOne picture;
ImageTwo picture2;

//Array of elipses used for coloring the images
ArrayList<sprayPaint> sprayPaints;

void setup() {
  size(640, 280); 
//Call the images, set them to the full screen
  picture = new ImageOne(0, 0);
  picture2 = new ImageTwo(0, 0);
//Create an array of spraypaints
  sprayPaints = new ArrayList<sprayPaint>();
}

void draw() {
  background(255); 
  //Call the variables
  picture2.display();

  picture.display();
  picture.dispRect();
  picture.imageOpac();
  
  //Create the spraypaints when called
  for (int i = sprayPaints.size() -1; i >= 0; i--) {
   sprayPaint sprayPaint = sprayPaints.get(i); 
    sprayPaint.display();
  //The spraypaints fade, so when they're opacity reaches Zero, they get removed from the array
    if (sprayPaint.fade()) {
      sprayPaints.remove(i);
    }
  }
}
//When the spacebar is pressed, the spraypaints are added to the screen at the mouse location
void keyPressed() {
 if (key == ' ') {
  sprayPaints.add(new sprayPaint(mouseX, mouseY, spraySize)); 
 }
 //If the S key is pressed, then the image will be saved
  if(key == 's') {
   String s = "img" + ".jpg";
   save(s);
   j++;
  }
}