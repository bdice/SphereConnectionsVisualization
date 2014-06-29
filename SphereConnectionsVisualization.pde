// SphereConnectionsVisualization
// Written by: @Bradley_Dice
// Purpose: Draws nodes as in a network visualization

int maxNodes = 1000; // Will try to place this many nodes, but overlapping nodes won't be added.
int maxPulses = 100; // Will not draw more pulses if this many exist.
boolean drawFullScreen = true; // Draw visualization in fullscreen by default?

ArrayList<NetNode> nodes = new ArrayList<NetNode>();
ArrayList<PacketPulse> pulses = new ArrayList<PacketPulse>();
PVector cameraOrientation;
PVector centerPosition = new PVector(0, 0, 0);
float spinTheta;

void setup() {
  size(displayWidth, displayHeight, OPENGL);
  noStroke();
  fill(204);
  for (int i = 0; i<maxNodes; i++) {
    NetNode n = new NetNode();
    PVector nPos = n.getPosition();
    boolean addMe = true;
    for(int j = 0; j < nodes.size(); j++){
      PVector jPos = nodes.get(j).getPosition();
      PVector diffPos = PVector.sub(nPos, jPos);
      if( diffPos.mag() < 0.05 * height){
        addMe = false;
      }
    }
    if(addMe == true){
      nodes.add(n);
    }
  }
}

void draw() {
  background(0);
  spinTheta += (mouseX - width/2)*0.00001;
  cameraOrientation = new PVector(0, (mouseY/1.5 + 30) / tan(PI*30.0 / 180.0));
  cameraOrientation.rotate(spinTheta);
  camera(cameraOrientation.x, 0, cameraOrientation.y, 0, 0, 0, 0, 1, 0);
  perspective(PI/3.0, float(width)/float(height), 0.0001, height*4);

  for (int i = 0; i < nodes.size (); i++) {
    nodes.get(i).draw();
  }


  for (int i = 0; i < nodes.size ()-1; i++) {
    for (int j = i+1; j < nodes.size (); j++) {
      if (Math.random() < 0.0002 && pulses.size() < maxPulses) {
        int pulseTime = (int) (100 * Math.random()) + 100;
        pulses.add(new PacketPulse(nodes.get(i).getPosition(), centerPosition, nodes.get(j).getPosition(), pulseTime));
      }
    }
  }

  for (int i = 0; i < pulses.size(); i++) {
    pulses.get(i).draw();
    if (pulses.get(i).received()) {
      pulses.remove(i);
    }
  }
  //saveFrame("/output/seq-####.tga");
}

boolean sketchFullScreen() {
  return drawFullScreen;
}

