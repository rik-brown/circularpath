/*
Circular Path
RB 2018-05-10
Calculating equally spaced positions on a circular path using position & velocity vectors
*/

PVector center, position, velocity;

int generations = 12; // generations = numsides

float size;
float columnWidth;                       // columnWidth  = R (radius of the circle around which the cells are travelling)
float segmentAngle = TWO_PI/generations; // segmentAngle = angle between two 'spokes' pointing to adjacent vertexes (when the complete polygon is drawn)
float angle;                             // angle        = angle 
float sideLength;
float completeness;
float epochsProgress = 1;



PShape poly;

void setup() {
  //frameRate(1);
  size(800,800);
  columnWidth = width * 0.25;
  textSize(20);
  size = 40;
  completeness = 1.0;
  
  center = new PVector(width*0.5, height*0.5); //Starting position is a point at 9'o'clock on the circular path 
  position = new PVector(center.x-columnWidth, center.y); //Starting position is a point at 9'o'clock on the circular path
  noFill();
  //fill(255);
  stroke(0);
  noStroke();
  stroke(255);
  ellipseMode(RADIUS);
}

void draw() {
  position = new PVector(center.x-columnWidth, center.y); //Starting position is a point at 9'o'clock on the circular path
  background(128,0,0);
  generations = int(map(mouseX,0,width,1,24));
  float frameCycle = radians(frameCount%360);
  float frameSine=sin(frameCycle);
  //float epochsProgress = 1;
  float epochsProgress = map(frameSine, -1, 1, 0.0, 0.5);
  //float epochsProgress = map(mouseY, 0, width, 0.0, 1.0);
  columnWidth = width * map(mouseY, 0, height, 0.1, 0.4);
  
  //line(position.x, position.y, position.x+columnWidth*2, position.y);
  segmentAngle = TWO_PI/generations * epochsProgress;
  angle = segmentAngle;
  ellipse(center.x, center.y, columnWidth, columnWidth);
  ellipse(center.x, center.y, 5, 5);
  for (int generation=1; generation<=generations+1; generation++) {
    PVector Center2Pos = PVector.sub(position, center);
    line(center.x, center.y, center.x+Center2Pos.x, center.y+Center2Pos.y);
    PVector Center2NewPos = Center2Pos.rotate(angle);
    PVector NewPos = new PVector(center.x+Center2NewPos.x, center.y+Center2NewPos.y);
    line(center.x, center.y, NewPos.x, NewPos.y);
    PVector velocity = PVector.sub(NewPos, position);
    line(position.x, position.y, position.x+velocity.x, position.y+velocity.y);
    ellipse(position.x, position.y, 5, 5);
  
    position.add(velocity);  
  }
  
}
