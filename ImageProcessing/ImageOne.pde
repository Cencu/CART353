class ImageOne {

  PImage img;
  float x;
  float y;

  float rectSize;


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
    float rectX = 50;
    float rectY = 50;
    float rectSize = 50;
    stroke(0);
    noFill();
    rectMode(CENTER);
    rect(mouseX,mouseY,rectSize, rectSize);
  }
  
  
  
  
}