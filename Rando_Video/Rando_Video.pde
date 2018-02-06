//Import two libraries that are needed
import processing.video.*;
import java.util.*; 

//Call the random java class
Random generator;

//call three floats used for color
float r, g, b;

//Call the array which stores the colums and rows and Z mapping
float[][] heights;

//Used for mapping Z
float zoff;

//The square for each pixel
float cell;

//Call the video class
Capture video;

//Call the number of colums and rows for the 3D perlin noise 
int numCols;
int numRows;

void setup() {

  //Indicate the size and the function which makes us create in 3D
  size(640, 480, P3D);

  zoff = 1000.0;
  //The "depth" of the noise mapping function, how close it will be relative to the screen
  cell = 10;

  //Indicate the number of colums and rows we want 
  numCols = 50;
  numRows = 40;

  //add the random generator for the gaussian function
  generator = new Random();

  //Call the video funtion
  video = new Capture(this, width, height);
  video.start();

  //This array essentially lets us store (x, y, z) values: i and j will let us determine x and y, while the stored val is z
  heights = new float[numCols][numRows];
}

void captureEvent(Capture c) {
  video.read();
}

// calculateHeights() is based on i, j, and a changing value of zoff
void calculateHeights() {

  for (int i = 0; i < numCols; i++) {
    for (int j = 0; j < numRows; j++) {

      //Assign z a perlin noise value based on a mapping of i, a mapping of j, and zoff
      float z = noise(map(i, 0, numCols, 0, 1), map(j, 0, numRows, 0, 1), zoff);

      //In heights[i][j], store a new height: a mapped version of z that will vary between -100 and 100
      heights[i][j] = map(z, 0, 1, -100, 100);
    }
  }

  //Change zoff for next time we call draw()
  zoff += 0.01;
}


void draw() {
  background(255);

  calculateHeights();

  video.loadPixels();

  //Change the perspective on our cell grid so we can see the heights better
  pushMatrix();
  //Location of the image
  translate(30, 30, -100);
  //Changes how flat the image will be
  rotateX(PI/5);

  //Call a double for loop to indicate all the columns and rows
  for (int i = 0; i < (numCols-1); i++) { 
    for (int j = 0; j < (numRows-1); j++) { 

      //Stroke adds a white border around the cells
      stroke(255);

      int multiplier = width/numCols;

      //Calculate the pixel location 
      //Constrain the location to the noise mapping
      int loc = (numCols - i*multiplier - 1) + j*multiplier * numCols;
      loc = constrain(loc, 0, video.pixels.length-1);

      //Call the random generator for the gaussian distribution 
      float num = (float) generator.nextGaussian();
      //Add the standard deviation (leaving it small for pixels to cluster easily)
      //Add the mean distribution
      float sd = 10;
      float mean = 320;
      // Multiply by the standard deviation and add the mean.
      float x = sd * num + mean;

      //Locate the pixels using RGB, within the screen, Add their location to the 
      //Gaussian distribution
      r = red (video.pixels[i+int(x)]);
      g = green (video.pixels[i+int(x)]);
      b = blue (video.pixels[i+int(x)]);

      //Fill the cells with RGB
      fill(r, g, b);

      //Add more transformations to the noise
      pushMatrix();

      translate(i * cell, j * cell, 0);

      //Add the shape in which the cells and video will be distributed
      beginShape(QUADS);

      //Add all four vertices of the quadrilateral 
      vertex(0, 0, heights[i][j]);
      vertex(cell, 0, heights[i+1][j]);
      vertex(cell, cell, heights[i+1][j+1]);
      vertex(0, cell, heights[i][j+1]);
      //Endshape demonstrates an end to manipulating the quadrilateral
      endShape();

      popMatrix();
    }
  }
  popMatrix();
}