/*
Circular Path
RB 2018-05-10
Calculating equally spaced positions on a circular path using position & velocity vectors
*/

PVector center, position, velocity;

float r, R, angle, sideLength;
int numSides = 6;
float segmentAngle = TWO_PI/numSides;

void setup() {
  size(800,800);
  R = width * 0.25;
  textSize(20);
  
  
  center = new PVector(width*0.5, height*0.5); //Starting position is a point at 9'o'clock on the circular path 
  position = new PVector(center.x-R, center.y); //Starting position is a point at 9'o'clock on the circular path
  noFill();
  ellipseMode(RADIUS);
}

void draw() {
  background(128);
  R = width * map(mouseY, 0, height, 0.1, 0.4);
  position = new PVector(center.x-R, center.y); //Starting position is a point at 9'o'clock on the circular path
  numSides = int(map(mouseX, 0, width, 2, 360));
  segmentAngle = TWO_PI/numSides;
  //r = map(mouseX, 0, width, 0, R*2);
  //sideLength = r*2;
  sideLength = 2 * R * sin(PI/numSides);
  r = sideLength * 0.5;
  ellipse(center.x, center.y, R, R);
  ellipse(center.x, center.y, r, r);
  fill(0);
  ellipse(center.x, center.y, 3, 3);
  noFill();
  text("R=" + R + " L=" + sideLength, 10, 20);
  angle = PI-segmentAngle*0.5;
  for (int step = 0; step < numSides; step ++) {
    PVector velocity = new PVector(sideLength*sin(angle), sideLength*cos(angle));
    fill(0);
    ellipse(position.x, position.y, 3, 3);
    noFill();
    ellipse(position.x, position.y, r, r);
    position.add(velocity);
    angle -= segmentAngle;
  }
}
