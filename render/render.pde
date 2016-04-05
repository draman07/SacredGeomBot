float baseSize;

PImage back;

void setup() {
  size(960, 960);
  smooth(3);
  baseSize = width > height ? height : width;
  colorMode(RGB, 255, 255, 255, 1);
  
  back = loadImage("back.png");
}


color backColor = #121818;
float rotation = 180.0;
int count = 3;
float radius = 0.3;
float offset = 0.3;
int genStart = 0;
int genEnd = 2;
float scaleGeneration = 0.99;
float offsetGeneration = 0.4;
float circleWeight = 3;
color circleColor = #dfdfdf;
float circleOpacity = 1.0;
color circleFillColor = #222222;
float circleFillOpacity = 0;
float dotWeight = 12;
color dotColor = #ffffff;
float dotOpacity = 1.0;
float lineWeight = 0.5;
color lineColor = #2ef9fb;
float lineOpacity = 0.5;

boolean showCenters = true;
boolean showNetwork = true;
boolean showIntersects = true;


void generate() {
  rotation = floor(random(8)) * 45;
  count = floor(random(3)) + 3;
  radius = random(0.8) + 0.1;
  offset = random(0.2) + 0.2;
  
  genStart = floor(random(2));
  genEnd = genStart + 2 + floor(random(1));  
  scaleGeneration = 1.0 - random(0.6);
  offsetGeneration = scaleGeneration - random(0.2);
  
  showCenters = random(1) > 0.5;
  showIntersects = random(1) > 0.6;
  showNetwork = random(1) > 0.3;
  if (showNetwork == false)
    dotColor = lineColor;
  
  circleWeight = random(8) + 0.1;
  circleOpacity = random(1);
  circleFillOpacity = 0;
  dotWeight = random(24);
  dotOpacity = 0.5 + random(0.5);
  lineWeight = random(2);
  lineOpacity = random(1);
}


ArrayList<Circle> centers;

void draw() {
  generate();
  
  image(back, 0, 0);
  //background(backColor);
  noFill();
  
  translate(width/2, height/2);
  
  rotate(radians(rotation)); // base rotation
  centers = new ArrayList<Circle>();
  drawGeneration(0, 0, 0, 1.0);
  
  // CENTER / INTERSECTS
  ArrayList<PVector> points = new ArrayList<PVector>();
    
  if (showCenters) {
    for (int i = 0; i < centers.size(); i++) {
      Circle c0 = centers.get(i);
      points.add(new PVector(c0.x, c0.y));
    }
  }
  if (showIntersects) {
    for (int i = 0; i < centers.size(); i++) {
      Circle c0 = centers.get(i);
      for (int j = 0; j < centers.size(); j++) {
        if (i == j)
          continue;
        Circle c1 = centers.get(j);
        
        PVector[] pts = c0.circleIntersection(c1);
        
        // de-duplicate points
        for (int pI = 0; pts != null && pI < pts.length; pI++) {
         PVector p = pts[pI];
         boolean found = false;
         for (int a = 0; a < points.size(); a++) {
           PVector p1 = points.get(a);
           if (p1.x == p.x && p1.y == p.y) {
             found = true;
             break;
           }
         }
         if (found == false) {
           points.add(p);
         }
        }
      }
    }
  }
  
  // draw lines
  if (showNetwork) {
    // for each point, draw a line to all other points 
    setStroke(lineColor, lineOpacity, lineWeight);
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      // start past myself
      for (int j = i+1; j < points.size(); j++) {
        PVector p1 = points.get(j);
        line(p.x, p.y, p1.x, p1.y);
      }
    }
  }
  
  // draw points
  setStroke(dotColor, dotOpacity, dotWeight);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    point(p.x, p.y);
  }
  
  // render
  saveFrame("render.png");
  noLoop();
  //exit();
}

void setStroke(color col, float opacity, float weight) {
  stroke(red(col), green(col), blue(col), opacity);
  strokeWeight(weight);
  noFill();
}

void setFill(color col, float opacity) {
  fill(red(col), green(col), blue(col), opacity);
}

void drawGeneration(int generation, float centerX, float centerY, float scale) {
  for (int i = 0; i < count; i++) {
    // determine rotation
    float rot = radians(i*360.0/count);
    
    // determine offset from center
    float off = baseSize * offset;
    off *= offsetGeneration * generation;
    
    // determine center
    float cX = centerX + off*sin(rot);
    float cY = centerY + off*cos(rot);
    
    // determine radius of circle - based on generational scaling
    float rad = baseSize * radius * scale;
    
    // hide culled generations
    if (generation >= genStart) {
      // log shape details connections
      centers.add(new Circle(cX, cY, rad/2.0));
      
      // draw
      setStroke(circleColor, circleOpacity, circleWeight);
      setFill(circleFillColor, circleFillOpacity);
      ellipse(cX, cY, rad, rad);
    }
    
   // draw generation from this shape
    if (generation < genEnd - 1) {
      drawGeneration(generation + 1, cX, cY, scale * scaleGeneration);
    }
  }
}

class Circle {
  float x;
  float y;
  float r;
  
  public Circle(float x, float y, float rad) {
    this.x = x;
    this.y = y;
    this.r = rad;
  }
  
  public PVector[] circleIntersection(Circle c) {
    /* Adapted from: http://paulbourke.net/geometry/circlesphere/tvoght.c */
    /* dx and dy are the vertical and horizontal distances between 
       the cirlce centers
     */
    float dx = c.x - x;
    float dy = c.y - y;
    
    /* Determine the straight-line distance between the centers */
    float d = dist(x, y, c.x, c.y);
    
    /* Check for solvability */
    if (d > (r + c.r)) 
      return null;
    if (d < abs(r - c.r))
      return null;
  
    /* 'point 2' is the point where the line through the circle
       intersection points crosses the line between the circle
       centers.
     */
    /* Determine the distance from point 0 to point 2 */
    float a = ((r*r) - (c.r*c.r) + (d*d)) / (2.0 * d);
    
    /* Determine the coordinates of point 2 */
    float x2 = x + (dx * a/d);
    float y2 = y + (dy * a/d);
    
    /* Determine the distance from point 2 to either of the
       intersection points.
     */
    float h = sqrt(r*r-a*a);
  
    /* Now determine the offset of the intersection points from
       point 2.
     */
    float rx = -dy * (h/d);
    float ry = dx * (h/d);
  
    /* Determine the absolute interesction points */
    return new PVector[] {
      new PVector(x2 + rx, y2 + ry),
      new PVector(x2 - rx, y2 - ry)
    };
  }
}