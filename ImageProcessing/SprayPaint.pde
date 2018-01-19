class sprayPaint {
  
  float x; 
  float y; 
  float spraySize = 50;
  
  sprayPaint(float _x, float _y, float _size) {
   x = _x;
   y = _y;
   spraySize = _size;
  }
  
  void display() {
   float r = random(0,255);
   float g = random(0,255);
   float b = random(0,255);
   float opac = random(0,255);
   
   fill(r,g,b, opac);
    ellipse(x,y,spraySize,spraySize);
  }
  
  
}