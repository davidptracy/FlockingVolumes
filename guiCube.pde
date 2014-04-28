class guiCube {

  PVector location;
  float r, radius, strokeW;

  //mouse interaction
  boolean dragging = false;
  PVector dragOffset;
  
  PImage gCube;

  guiCube(float x, float y, PImage img) {
    location = new PVector(x, y);
    gCube = img;
    r = 0;
    radius = 50;
    dragOffset = new PVector();
  }

  void run() {
    display();
    update();
  }

  void update() {
    r += .1;
    radius = 50 + (5*sin(r)); 
    if (r>100) {
      r=0;
    }
  }

  void display() {
    imageMode(CENTER);
    ellipseMode(RADIUS);
    
    noFill();
    if(dragging){
    fill(255,0,0,25);
    strokeWeight(1+sin(r));
    ellipse(location.x, location.y, radius, radius);
    }
    
    image(gCube, location.x, location.y, 50, 50);
  }

  void clicked(int mx, int my) {
    float d = dist(mx, my, location.x, location.y);
    if (d < 50) {
      dragging = true;
      dragOffset.x = location.x-mx;
      dragOffset.y = location.y-my;
    }
  }

  void stopDragging() {
    dragging = false;
  }

  void drag(int mx, int my) {
    if (dragging) {
      location.x = mx + dragOffset.x;
      location.y = my + dragOffset.y;
    }
  }
}

