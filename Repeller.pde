class Repeller {

  PVector location, velocity;
  float radius = 50;
  //Gravitational Constant
  float G = 100;
  float iterator;

  Repeller(float x, float y, float z) {
    location = new PVector(x, y, z);
    velocity = PVector.random3D();
    velocity.limit(10);
    println();
  }

  void run() {
    display();
    update();
    borders();
  }

  void display() {
    iterator += .05;

    if (iterator > 100) {
      iterator = 0;
    }

    pushMatrix();
    translate(location.x, location.y, location.z);
    noStroke();
    fill(100, 100, 100, 50);
    sphere(radius+(25*sin(iterator)));
    popMatrix();
  }
  
  void update(){
  location.add(velocity);
  }
  
    // This method makes the boids bounce off the edges
  void borders() {
    if (location.x - radius < -1000) { 
      location.x = -1000 + radius;
      velocity.x *= -1;
    }
    if (location.x + radius > 1000) { 
      location.x = 1000 - radius;
      velocity.x *= -1;
    }
    if (location.y - radius < -1000) { 
      location.y = -1000 + radius;
      velocity.y *= -1;
    }
    if (location.y + radius > 1000) { 
      location.y = 1000 - radius;
      velocity.y *= -1;
    }
    if (location.z - radius < -1000) { 
      location.z = -1000 + radius;
      velocity.z *= -1;
    }
    if (location.z + radius > 1000) { 
      location.z = 1000 - radius;
      velocity.z *= -1;
    }
  }

  PVector repel(Boid b) {
    //calculates the direction force
    PVector dir = PVector.sub(location, b.location);
    float d = dir.mag();
    dir.normalize();
    d = constrain(d, 5, 100);
    float force = -1 * G/(d*d);
    dir.mult(force);
    return dir;
  }
}

