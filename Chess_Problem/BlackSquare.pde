class BlackSquare {

  int x;
  int y;
  int size;
  int col;
  float food;

  boolean black;

  BlackSquare(int x, int y, int size, boolean black) {
    this.x = x;
    this.y = y;
    this.size = size;

    this.black = !black;

    // establish a random amount of food to start with
    this.food = random(500, 1000);

    if (black) {
      this.col = 0;
    } else {
      this.col = 255;
    }
  }

  void render() {

    // if it is not a black square
    if (!this.black) {

      // reflect the amount of food
      col = (int)map(this.food, 0, 1000, 255, 0);

    }

    fill(col, 10);
    rect(this.x * size, this.y * size, size, size);
  }

  void update() {
    if(!this.black && this.food > 0) {
      this.food--;
    }
  }

  void feed() {
    if (!this.black && this.food < 1000) {
      this.food += 10;
      
    }
  }
}