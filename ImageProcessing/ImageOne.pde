class ImageOne {

  PImage img;
  float x;
  float y;

  int rectSize;


  ImageOne(float _x, float _y) {
    img = loadImage("image.jpg");
    ;
    x = _x;
    y = _y;
  }

  void display() {
    image(img, x, y);
  }

  void dispRect() {

   /* int rectSize = 80;
    stroke(0);
    noFill();
    rectMode(CENTER);
    rect(mouseX,mouseY,rectSize, rectSize);*/
  }
  
  void imageOpac() {
    
    int xstart = constrain(mouseX-rectSize/2,0,img.width); 
  int ystart = constrain(mouseY-rectSize/2,0,img.height);
  int xend = constrain(mouseX + rectSize/2,0,img.width);
  int yend = constrain(mouseY + rectSize/2,0,img.height);
  int matrixsize = 3;
    
   img.loadPixels(); 
    
  }
  
  
}