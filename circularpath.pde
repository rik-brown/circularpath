/*
Circular Path
RB 2018-05-10
Calculating equally spaced positions on a circular path using position & velocity vectors
*/

PVector center, position, velocity;

float size, columnWidth, angle, sideLength, completeness;
int generations =12; // generations = numsides
float segmentAngle = TWO_PI/generations;

void setup() {
  size(800,800);
  columnWidth = width * 0.3;
  textSize(20);
  size = 20;
  completeness = 0.5;
  
  center = new PVector(width*0.5, height*0.5); //Starting position is a point at 9'o'clock on the circular path 
  position = new PVector(center.x-columnWidth, center.y); //Starting position is a point at 9'o'clock on the circular path
  noFill();
  fill(255);
  stroke(0);
  noStroke();
  ellipseMode(RADIUS);
}

void draw() {
  background(128,0,0);
  float frameCycle = radians(frameCount%360);
  float frameSine=sin(frameCycle);
  float epochsProgress = map(frameSine, -1, 1, 0.0, 1.0);
  //float epochsProgress = map(mouseX, 0, width, 0.0, 1.0);
  //float scalingFactorY = map(mouseY, 0, width, 0.0, 1.0);
  //columnWidth = width * map(mouseY, 0, height, 0.1, 0.4);
  position = new PVector(center.x-columnWidth, center.y); //Starting position is a point at 9'o'clock on the circular path
  stroke(255);
  line(position.x, position.y, position.x+columnWidth*2, position.y);
  //generations = int(map(mouseX, 0, width, 2, 360));
  segmentAngle = TWO_PI*epochsProgress*completeness/generations;
  //size = map(mouseX, 0, width, 0, columnWidth*2);
  //sideLength = size*2;
  sideLength = 2 * columnWidth * sin(PI/generations) * epochsProgress * completeness;
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
    float fillCol = map (generation, 1, generations+1, 0, 255);
    fill(fillCol);
    ellipse(position.x, position.y, 3, 3);
    //noFill();
    ellipse(position.x, position.y, size, size);
    position.add(velocity);
    angle -= segmentAngle; // Need to figure out how this angle changes through the generations. The 'generations+1' could be a bit tricky!
  }
}
