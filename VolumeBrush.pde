import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.volume.*;
import toxi.math.waves.*;
import toxi.processing.*;

class VBrush {

  //  These parameters set the final face count on the mesh
  int DIMX=10;
  int DIMY=10;
  int DIMZ=10;

  float ISO_THRESHOLD = 0.1;
  Vec3D SCALE=new Vec3D(1, 1, 1).scaleSelf(100);

  float currScale=4;
  float density=0.5;

  VolumetricSpace volume;
  VolumetricBrush brush;
  IsoSurface surface;
  TriangleMesh mesh;  
  AbstractWave brushSize;
  
  ToxiclibsSupport gfx;

  ArrayList<PVector> locations;  

  VBrush(PApplet app) {
    
    gfx = new ToxiclibsSupport(app);

    locations = new ArrayList<PVector>();
    volume = new VolumetricSpaceArray(SCALE, DIMX, DIMY, DIMZ);
    brush = new RoundBrush(volume, SCALE/x/2);
    brushSize = new SineWave(0,0.1, SCALE.x*0.07, SCALE.x*0.1);
    surface = new ArrayIsoSurface(volume);
    mesh = new TriangleMesh();
  }

  void addLocation(PVector v) {

    PVector myVec = new PVector();
    locations.add(myVec);
  }

  void update() {
    for (PVector v : locations) {
      Vec3D brushLoc = new Vec3D(v.x, v.y, v.z);
      brush.drawAtAbsolutePos(brushLoc, density);
    }
  }

  void render() {
    //brush.setSize(brushSize.update());
    //Vec3D brushLoc = new Vec3D((boidLoc.x, boidLoc.y, boidLoc.z));
    //brush.drawAtAbsolutePos(brushLoc, density);
    //volume.closeSides();
    //surface.reset();
    //surface.computerSurfaceMesh(mesh, ISO_THRESHOLD);
    gfx.mesh(mesh);
  }
}

