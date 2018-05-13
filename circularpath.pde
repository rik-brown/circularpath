/*
Circular Path
RB 2018-05-10
Calculating equally spaced positions on a circular path using position & velocity vectors
*/

PVector center, position, velocity;

float size, columnWidth, angle, sideLength, completeness;
int generations =3; // generations = numsides
float segmentAngle = TWO_PI/generations;

PShape poly;

void setup() {
  frameRate(15);
  size(800,800);
  columnWidth = width * 0.4;
  textSize(20);
  size = 40;
  completeness = 1.0;
  
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
  generations = int(map(mouseX,0,width,2,100));
  float frameCycle = radians(frameCount%360);
  float frameSine=sin(frameCycle);
  //float epochsProgress = 1;
  //float epochsProgress = map(frameSine, -1, 1, 0.0, 1.0);
  float epochsProgress = map(mouseY, 0, width, 0.0, 1.0);
  //float scalingFactorY = map(mouseY, 0, width, 0.0, 1.0);
  //columnWidth = width * map(mouseY, 0, height, 0.1, 0.4);
  position = new PVector(center.x-columnWidth, center.y); //Starting position is a point at 9'o'clock on the circular path
  stroke(255);
  line(position.x, position.y, position.x+columnWidth*2, position.y);
  //generations = int(map(mouseX, 0, width, 2, 360));
  segmentAngle = TWO_PI*completeness*epochsProgress/generations;
  //size = map(mouseX, 0, width, 0, columnWidth*2);
  //sideLength = size*2;
  sideLength = 2 * columnWidth * sin(PI/generations) * epochsProgress * completeness;
  //size = sideLength * 0.5;
  noFill();
  ellipse(center.x, center.y, columnWidth, columnWidth);
  ellipse(center.x, center.y, size, size);
  //fill(0);
  ellipse(center.x, center.y, 3, 3);
  noFill();
  text("columnWidth=" + columnWidth + " L=" + sideLength, 10, 20);
  angle = PI-segmentAngle*0.5;
  poly = createShape();
  poly.beginShape();
  poly.noFill();
  poly.stroke(255);
  for (int generation = 1; generation <= generations+1; generation ++) {
    PVector velocity = new PVector(sideLength*sin(angle), sideLength*cos(angle));
    PVector toCenter = PVector.sub(position, center);
    float fillCol = map (generation, 1, generations+1, 0, 255);
    //fill(fillCol);
    //ellipse(position.x, position.y, 3, 3);
    //noFill();
    pushMatrix();
    translate(position.x, position.y);
    rotate(toCenter.heading());
    //rotate(segmentAngle-HALF_PI);
    //rotate(HALF_PI);
    //point(0,0);
    ellipse(0, 0, size, size*0.3);
    popMatrix();
    poly.vertex(position.x, position.y);
    position.add(velocity);
    angle -= segmentAngle; // Need to figure out how this angle changes through the generations. The 'generations+1' could be a bit tricky!
  }
  
  poly.endShape(CLOSE);
  shape(poly,0,0);
  ellipse(center.x, center.y, columnWidth, columnWidth);
  
}
