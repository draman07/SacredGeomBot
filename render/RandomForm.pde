
public class RandomForm extends Forms {
  public RandomForm() {
    super();
    
    // 1: Decide dark/light background
    darkBack = random(1) < 0.5;
    println(darkBack ? "going dark" : "going light");
    
    // 2: Pick a random backdrop based on darkness choice
    PImage background;
    if (darkBack == true) {
      float rand = random(4);
      back = loadImage("dark_0" + (int)rand + ".jpg");
    } else {
      float rand = random(4);
      back = loadImage("light_0" + (int)rand + ".jpg");
    }
    
    // 3: Random filter on background
    if (random(1) < 0.15) {
      backFilter = INVERT;
      darkBack = !darkBack;
      println("invert: " + backFilter);
    } else if (random(1) < 0.05) {
      println("posterize");
      backFilter = POSTERIZE;
      backFilterAmt = 3;
    } else if (random(1) < 0.2) {
      println("blur");
      backFilter = BLUR;
      backFilterAmt = 4;
    } else if (random(1) < 0.05) {
      println("dilate");
      backFilter = DILATE;
    } else if (random(1) < 0.2) {
      println("gray");
      backFilter = GRAY;
    }
    
    
    
    
    // 3: Random inverse
    // 4: Lighten and draw it
    // (bias colors based on backdrop)
    
    
    
    

    // circle container
    Form form = new Form(width, height, width/2, height/2);
    form.genStart = 0;
    form.genEnd = 0;
    form.shapeCount = 1;
    form.offsetGeneration = 0;
    form.scaleGeneration = 1.04;
    form.shapeRadius = 0.73;
    form.shapeWeight = 8.0;
    form.shapeOpacity = 1.0;
    form.shapeColor = #ffffff;
    form.showCenters = false;
    form.showNetwork = false;
    form.shapeFillOpacity = 0.4;
    form.shapeFillColor = #000000;
    form.blur = 2;
    forms.add(form);

    //// backbone circles
    //backbone = new Form(width, height, width/2, height/2);
    //backbone.genStart = 0;
    //backbone.genEnd = 2;
    //backbone.shapeRadius = rad;
    //backbone.shapeOffset = off;
    //backbone.showCenters = false;
    //backbone.showNetwork = false;
    //backbone.networkStrokeColor = #bbeaf7;
    //backbone.networkStrokeWeight = 2.0;
    //backbone.networkStrokeOpacity = 0.9;
    //backbone.shapeColor = #ffffff;
    //backbone.shapeWeight = 2;
    //backbone.blur = 4;
    //forms.add(backbone);
    
    //// network
    //net = new Form(width, height, width/2, height/2);
    //net.genStart = 0;
    //net.genEnd = 2;
    //net.trackCenters = new boolean[] { true, true, true };
    //net.shapeRadius = rad;
    //net.shapeOffset = off;
    //net.showShapes = false;
    //net.showCenters = true;
    //net.showNetwork = true;
    //net.networkStrokeColor = #adf8fe;
    //net.networkStrokeWeight = 2.0;
    //net.networkStrokeOpacity = 0.9;
    //net.shapeColor = #ffffff;
    //net.shapeWeight = 2;
    //net.centerStrokeWeight = 9;
    //net.blur = 3;
    //forms.add(net);
    
    //// centers
    //Form cents = new Form(width, height, width/2, height/2);
    //cents.genStart = 0;
    //cents.genEnd = 2;
    //cents.trackCenters = new boolean[] { true, true, true };
    //cents.shapeRadius = rad;
    //cents.shapeOffset = off;
    //cents.showShapes = false;
    //cents.showCenters = true;
    //cents.showNetwork = false;
    //cents.networkStrokeColor = #adf8fe;
    //cents.networkStrokeWeight = 2.0;
    //cents.networkStrokeOpacity = 0.9;
    //cents.shapeColor = #ffffff;
    //cents.shapeWeight = 2;
    //cents.centerStrokeWeight = 9;
    //cents.blur = 2;
    //forms.add(cents);
  }
}