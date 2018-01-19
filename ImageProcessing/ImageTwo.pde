class ImageTwo {

  PImage img2;

  float x;
  float y;
  float thisTint = 255;
  int rectSize;


  ImageTwo(float _x, float _y) {
    img2 = loadImage("image1.jpg");
    ;
    x = _x;
    y = _y;
  }

  void display() {
    thisTint = constrain(thisTint, 255, 255);
    tint(thisTint); 

    img2.resize(640, 280);
    img2.mask(img2);

    image(img2, x, y);
    if (mousePressed) {
    }
  }

  void sprayPaint() {
    float eX = mouseX;
    float eY = mouseY;
    if (key == 's' || key == 'S') {

      ellipse(eX, eY, 30, 30);
    }
  }
}