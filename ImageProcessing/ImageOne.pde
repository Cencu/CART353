class ImageOne {
//Call all the variables
//Call the images, X and Y are the locations for the image
//Imgtint is the opacity of the first image
//RectX and Y call the rectangle
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
//We take RectX and Y to take a random location on the image
    rectX = int(random(img.width));
    rectY = int(random(img.height));
    //Use int loc to find the 1D location 
    int loc = mouseX + mouseY*img.width;
    // Look up the RGB color in the first image
    loadPixels();
    float r = green(img.pixels[loc]);
    float g = blue(img.pixels[loc]);
    float b = red(img.pixels[loc]);

    // Draw a square at that location that takes different colors and mixes them up depending on image colors
    int rectSize = 80;
    noStroke();
    rectMode(CENTER);
    fill(r, g, b, 100);    
    rect(mouseX, mouseY, rectSize, rectSize);
  }
//If the user presses the left or right mouse button, the image tint fades, using mask to create a different type of image with the 
//second image
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