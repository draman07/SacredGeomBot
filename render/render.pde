void setup() { //<>//
  size(640, 640);  
  frameRate(30);
  smooth(4);
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
}

void draw() {
  background(360);
  
  translate(width/2.0, height/2.0);
  float rad = width*0.35;
  
  blendMode(SUBTRACT);

  fill(360, 100, 100, 100); // red
  noiseSeed(1);
  blobCircle(rad);
  
  fill(135, 100, 100, 100); // green
  noiseSeed(2);
  blobCircle(rad);

  fill(225, 100, 100, 100); // blue
  noiseSeed(3);
  blobCircle(rad);


  // video
  saveFrame("render.png");
  noLoop();
  exit();
}

void blobCircle(float rad) {
  beginShape();
  for (float i = 0; i < 360; i += 1) {
    float x = sin(radians(i));
    float y = cos(radians(i));
    
    x += 0.45*(noise(x+frameCount/120.0)-0.5);
    y += 0.45*(noise(y+frameCount/120.0)-0.5);
    
    x *= rad;
    y *= rad;
    
    vertex(x, y);
  }
  endShape(CLOSE);
}