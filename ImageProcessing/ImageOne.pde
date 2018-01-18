class ImageOne {

  PImage img;
  float x;
  float y;
  float imgtint = 255;

  float rectX;
  float rectY;

  int rectSize;


  ImageOne(float _x, float _y) {
    img = loadImage("image.jpg");
    ;
    x = _x;
    y = _y;
  }

  void display() {
    tint(255, imgtint);
    imageMode(CORNER);
    image(img, x, y);
  }

  void dispRect() {

    rectX = int(random(img.width));
    rectY = int(random(img.height));
    int loc = mouseX + mouseY*img.width;
    // Look up the RGB color in the source image
    loadPixels();
    float r = green(img.pixels[loc]);
    float g = blue(img.pixels[loc]);
    float b = red(img.pixels[loc]);

    // Draw an ellipse at that location with that color
    int rectSize = 80;
    noStroke();
    ellipseMode(CENTER);
    fill(r, g, b, 100);    
    ellipse(mouseX, mouseY, rectSize, rectSize);
  }

  void imageOpac() {
    if (mouseButton == LEFT) {
      imgtint--;
    }

    if (mouseButton == RIGHT) {
      imgtint++;
    }
    imgtint = constrain(imgtint, 20, 255);
  }
}