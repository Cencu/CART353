class WhiteSquare {

  int x;
  int y;
  int size;
  int col;
  float food;

  boolean white;

  WhiteSquare(int x, int y, int size, boolean white) {
this.x = x;
    this.y = y;
    this.size = size;

    this.white = white;

    // establish a random amount of food to start with
    this.food = random(500, 1000);

    if (white) {
      this.col = 255;
    } 
  }

  void render() {

    // if it is a black square
    if (!this.white) {

      // reflect the amount of food
      col = (int)map(this.food, 0, 1000, color(255,0,0), color(0,255,0));

    }

    fill(col, 10);
    rect(this.x * size, this.y * size, size, size);
  }

  void update() {
    if(!this.white && this.food > 0) {
      this.food--;
    }
  }

  void feed() {
    if (!this.white && this.food < 1000) {
      this.food += 10;
      
    }
  }
}