/*
Circular Path
RB 2018-05-10
Calculating equally spaced positions on a circular path using position & velocity vectors
*/

PVector center, position, velocity;

float size, columnWidth, angle, sideLength;
int generations =12; // generations = numsides
float segmentAngle = TWO_PI/generations;

void setup() {
  size(800,800);
  columnWidth = width * 0.3;
  textSize(20);
  size = 20;
  
  
  center = new PVector(width*0.5, height*0.5); //Starting position is a point at 9'o'clock on the circular path 
  position = new PVector(center.x-columnWidth, center.y); //Starting position is a point at 9'o'clock on the circular path
  noFill();
  ellipseMode(RADIUS);
}

void draw() {
  background(128);
  float frameCycle = radians(frameCount%360);
  float frameSine=sin(frameCycle);
  float scalingFactorX = map(frameSine, -1, 1, 0.0, 1.0);
  //float scalingFactorX = map(mouseX, 0, width, 0.0, 1.0);
  //float scalingFactorY = map(mouseY, 0, width, 0.0, 1.0);
  //columnWidth = width * map(mouseY, 0, height, 0.1, 0.4);
  position = new PVector(center.x-columnWidth, center.y); //Starting position is a point at 9'o'clock on the circular path
  //generations = int(map(mouseX, 0, width, 2, 360));
  segmentAngle = TWO_PI*scalingFactorX/generations;
  //size = map(mouseX, 0, width, 0, columnWidth*2);
  //sideLength = size*2;
  sideLength = 2 * columnWidth * sin(PI/generations) * scalingFactorX;
  //size = sideLength * 0.5;
  //ellipse(center.x, center.y, columnWidth, columnWidth);
  //ellipse(center.x, center.y, size, size);
  //fill(0);
  //ellipse(center.x, center.y, 3, 3);
  //noFill();
  text("columnWidth=" + columnWidth + " L=" + sideLength, 10, 20);
  angle = PI-segmentAngle*0.5;
  for (int generation = 1; generation <= generations+1; generation ++) {
    PVector velocity = new PVector(sideLength*sin(angle), sideLength*cos(angle));
    fill(0);
    ellipse(position.x, position.y, 3, 3);
    noFill();
    ellipse(position.x, position.y, size, size);
    position.add(velocity);
    angle -= segmentAngle;
  }
}
