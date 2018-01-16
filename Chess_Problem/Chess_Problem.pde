boolean white;
boolean black;
WhiteSquare[][] grid;
BlackSquare[][] grid2;
int rows;
int cols;
int gridSquareSize;

void setup() {

  size(400, 400);
  noStroke();
  rows = 8;
  cols = 8;
  gridSquareSize = 50;

  grid = new WhiteSquare[cols][rows];
  grid2 = new BlackSquare[cols][rows];
  // do a double for loop to run through the grid 2D array
  // creating new alternating black and white GridSquare objects
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new WhiteSquare(i, j, gridSquareSize, white);
      white = !white;
    }
    white = !white;
  }
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid2[i][j] = new BlackSquare(i, j, gridSquareSize, !black);
      black = !black;
    }
    black = !black;
  }
}

void draw() {

  // every time daw runs, we want to go through the grid 2d array and update and render each GridSquare object
  // update represents getting hungry
  // render takes care of drawing
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].update();
      grid[i][j].render();
    }
  }
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid2[i][j].update();
      grid2[i][j].render();
    }
  }
  // determine which gid slot mouse is over
  int currentHorizSquare = mouseX / 50;
  int currentVertSquare = mouseY / 50;

  // do mouseOver-based feeding only on **valid** grid slots
  if (currentHorizSquare >= 0 && currentHorizSquare <= 7 && currentVertSquare >= 0 && currentVertSquare <= 7) {
    grid[currentHorizSquare][currentVertSquare].feed();
    grid2[currentHorizSquare][currentVertSquare].feed();
  }
}