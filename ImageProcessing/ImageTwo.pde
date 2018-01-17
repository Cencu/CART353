class ImageTwo {
  
  PImage img2;
  float x;
  float y;

  int rectSize;


  ImageTwo(float _x, float _y) {
    img2 = loadImage("image1.jpg");
    ;
    x = _x;
    y = _y;
  }

  void display() {
    img2.resize(640,280);
    image(img2, x, y);
  }
  
  
  
  
}