class sprayPaint {
  
  float x; 
  float y; 
  float spraySize = 50;
   float r = random(0,255);
   float g = random(0,255);
   float b = random(0,255);
   float opac = random(0,255);
  
  sprayPaint(float _x, float _y, float _size) {
   x = _x;
   y = _y;
   spraySize = _size;
  }
  
  void display() {
  
   
   fill(r,g,b, opac);
    ellipse(x,y,spraySize,spraySize);
  }
  
  boolean fade() {
    opac--;
    if (opac < 0) {
      return true;
    } else {
     return false; 
    }
      
    
  }
  
}