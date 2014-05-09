class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

    Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);  // Passing the entire list of boids to each boid individually
    }
  }

  void applyRepeller(Repeller r) {
    for (Boid b : boids) {
      PVector force = r.repel(b);        
      b.applyForce(force);
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
    vb.addLocation(b.location);
  }
}

