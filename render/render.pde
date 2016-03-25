float baseSize;

void setup() {
  size(720, 720);
  smooth(8);
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
  frameRate(1);

  baseSize = width;
}

// randomize these
float baseRot;
float shapeCount = floor(random(4) + 2);
float radius = (random(1) - 0.2) + 0.2;
float offset = random(1) - 0.5;
int genEnd = floor(random(1)) + 3;
int genStart = genEnd - (floor(random(1)) + 1);
float scaleGeneration = ((random(1) - 0.4) + 0.6);
float offsetGeneration = 0.4;
float backColor = 0;
float drawColor = 255;
float drawWeight = random(2.0);

void draw() {
  baseRot = floor(random(1) * 4) * 90.0;
  shapeCount = floor(random(4) + 2);
  radius = (random(1) / 3.0) + 0.4;
  offset = random(1) - 0.5;
  genEnd = floor(random(1)) + 3;
  genStart = genEnd - (floor(random(1)) + 1);
  scaleGeneration = random(1)/8.0 + 0.8;
  offsetGeneration = 0.4;
  backColor = 0;
  drawColor = 255;
  drawWeight = random(2.0);


  translate(width/2.0,height/2.0);


  background(backColor);
  stroke(drawColor);
  strokeWeight(drawWeight);
  noFill();

  rotate(radians(baseRot));
  drawGeneration(0, 1.0);


  // render
  saveFrame("render.png");
  noLoop();
  exit();
}

void drawGeneration(int generation, float scale) {
  for (int i = 0; i < shapeCount; i++) {
    rotate(radians(360.0/shapeCount));

    float rad = baseSize*radius*scale;

    // TEMP:
    // stroke(255,255,255,255-generation*70);

    pushMatrix();

    float off = baseSize*offset;
    off *= offsetGeneration*generation;
    translate(off, 0);

    // hide culled generations
    if (generation >= genStart)
      ellipse(0, 0, rad, rad);

    if (generation < genEnd-1) {
      drawGeneration(generation + 1, scale * scaleGeneration);
    }

    popMatrix();
  }
}
