class Repeller {

  PVector location;
  float r = 25;
  //Gravitational Constant
  float G = 100;

  Repeller() {
    location = new PVector(random(1000), random(1000), random(1000) );
    println();
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    fill(100, 100, 100);
    sphere(r);
    popMatrix();
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

