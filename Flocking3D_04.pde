import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.volume.*;
import toxi.math.waves.*;
import toxi.processing.*;

import peasy.*;
import processing.opengl.*;

PeasyCam cam;
PMatrix3D currCameraMatrix;
PGraphics3D g3;

//Initializes the repeller object
Repeller repeller;
Repeller repeller2;

//Initializes the Volumetric brush
VBrush vb;

float sepVal, aliVal, cohVal;
float radius, maxForce, maxSpeed;
float desiredSeparation, alignThreshold, cohesionThreshold;

float camRot;
Flock flock;

PImage gCube1, gCube2, gCube3;
guiCube cohCube, sepCube, aliCube;

void setup() {
  size(800, 800, OPENGL);
  smooth();

  vb = new VBrush(this);

  gCube1 = loadImage("Cube04-01.png");
  gCube2 = loadImage("Cube04-02.png");
  gCube3 = loadImage("Cube04-03.png");

  cohCube = new guiCube(200, height - 20, gCube1);
  sepCube = new guiCube(20, height - 200, gCube2);
  aliCube = new guiCube(20, height-20, gCube3);

  repeller = new Repeller(random(1000), random(1000), random(1000));
  repeller2 = new Repeller(random(1000), random(1000), random(1000));

  maxForce = .08;
  maxSpeed = 8;
  desiredSeparation = 200;
  alignThreshold = 175;
  cohesionThreshold = 50;

  // New PeasyCam
  cam = new PeasyCam(this, 800);
  g3 = (PGraphics3D)g;

  //  Initializes the flock with an initial set of boids
  int startCount = 25;
  flock = new Flock();
  for (int i=0; i<startCount; i++) {
    Boid b = new Boid(PVector.random3D(), radius);
    flock.addBoid(b);
  }
}

void draw() {

  background(0);

  repeller.run();
  repeller2.run();
  flock.run();
  flock.applyRepeller(repeller);
  flock.applyRepeller(repeller2);

  colorMode(RGB);
  // Axis for world coordinate system
  stroke(255, 0, 0);
  line(0, 0, 0, 50, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 50, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 50);

  pushMatrix();
  translate(0, 0, 00);
  noFill();
  strokeWeight(1);
  stroke(0);
  box(500);
  popMatrix();

  gui();

  if (keyPressed) flock.addBoid(new Boid(PVector.random3D(), radius));
}

void gui() {
  currCameraMatrix = new PMatrix3D(g3.camera);
  camera(); 

  fill(255, 100, 100);
  //  rectMode(CORNER);
  //  rect(0, 0, 500, 500);

  guiDraw();
  g3.camera = currCameraMatrix;
}

void guiDraw() {

   

  sepVal = dist(cohCube.location.x, cohCube.location.y, sepCube.location.x, sepCube.location.y);
  aliVal = dist(cohCube.location.x, cohCube.location.y, aliCube.location.x, aliCube.location.y);
  cohVal = dist(sepCube.location.x, sepCube.location.y, aliCube.location.x, aliCube.location.y);

  sepVal = map(sepVal, 20, 200, 0, 10);
  aliVal = map(aliVal, 20, 200, 0, 10);
  cohVal = map(cohVal, 20, 200, 0, 10);

  float angleA = PVector.angleBetween(cohCube.location, sepCube.location);
  float angleB = PVector.angleBetween(cohCube.location, aliCube.location);
  float angleC = PVector.angleBetween(sepCube.location, aliCube.location);
  println(angleA);

  pushMatrix();
  translate((cohCube.location.x + sepCube.location.x)/2, (cohCube.location.y + sepCube.location.y)/2);
  rotate(angleA);
  fill(255, 100, 100);
  text("S : " + sepVal, 0, 0);
  popMatrix();

  pushMatrix();
  translate((cohCube.location.x + aliCube.location.x)/2, (cohCube.location.y + aliCube.location.y)/2);
  rotate(angleB);
  fill(255, 100, 100);
  text("A : " + aliVal, 0, 0);
  popMatrix();

  pushMatrix();
  translate((sepCube.location.x + aliCube.location.x)/2, (sepCube.location.y + aliCube.location.y)/2);
  rotate(angleC);
  fill(255, 100, 100);
  text("C : " + cohVal, 0, 0);
  popMatrix();

  println("sepVal = " + sepVal + "   cohVal = " + cohVal + "   aliVal = " + aliVal);

  cohCube.run(); 
  cohCube.drag(mouseX, mouseY);
  sepCube.run(); 
  sepCube.drag(mouseX, mouseY);
  aliCube.run(); 
  aliCube.drag(mouseX, mouseY);
  
  stroke(255, 100, 100);
  strokeWeight(1);
  line(cohCube.location.x, cohCube.location.y, sepCube.location.x, sepCube.location.y);
  line(cohCube.location.x, cohCube.location.y, aliCube.location.x, aliCube.location.y);
  line(sepCube.location.x, sepCube.location.y, aliCube.location.x, aliCube.location.y); 
}

void mousePressed() {
  cohCube.clicked(mouseX, mouseY);
  sepCube.clicked(mouseX, mouseY);
  aliCube.clicked(mouseX, mouseY);
}

void mouseReleased() {
  cohCube.stopDragging();
  sepCube.stopDragging();
  aliCube.stopDragging();
}

