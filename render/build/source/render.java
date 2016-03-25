import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class render extends PApplet {

float baseSize;

public void setup() {
  
  
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
  frameRate(1);

  baseSize = width;
}

// randomize these
float baseRot;
float shapeCount = floor(random(4) + 2);
float radius = (random(1) - 0.2f) + 0.2f;
float offset = random(1) - 0.5f;
int genEnd = floor(random(1)) + 3;
int genStart = genEnd - (floor(random(1)) + 1);
float scaleGeneration = ((random(1) - 0.4f) + 0.6f);
float offsetGeneration = 0.4f;
float backColor = 0;
float drawColor = 255;
float drawWeight = random(2.0f);

public void draw() {
  baseRot = floor(random(1) * 4) * 90.0f;
  shapeCount = floor(random(4) + 2);
  radius = (random(1) / 3.0f) + 0.4f;
  offset = random(1) - 0.5f;
  genEnd = floor(random(1)) + 3;
  genStart = genEnd - (floor(random(1)) + 1);
  scaleGeneration = random(1)/8.0f + 0.8f;
  offsetGeneration = 0.4f;
  backColor = 0;
  drawColor = 255;
  drawWeight = random(2.0f);


  translate(width/2.0f,height/2.0f);


  background(backColor);
  stroke(drawColor);
  strokeWeight(drawWeight);
  noFill();

  rotate(radians(baseRot));
  drawGeneration(0, 1.0f);


  // render
  saveFrame("render.png");
  // noLoop();
  // exit();
}

public void drawGeneration(int generation, float scale) {
  for (int i = 0; i < shapeCount; i++) {
    rotate(radians(360.0f/shapeCount));

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
  public void settings() {  size(720, 720);  smooth(8); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "render" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
