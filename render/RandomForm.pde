
public class RandomForm extends Forms {
  public RandomForm() {
    super();
    
    // 1: Decide dark/light background
    darkBack = random(1) < 0.5;
    println(darkBack ? "going dark" : "going light");
    
    // 2: Pick a random backdrop based on darkness choice
    PImage background;
    if (darkBack == true) {
      float rand = random(10);
      back = loadImage("dark_0" + (int)rand + ".jpg");
    } else {
      float rand = random(10);
      back = loadImage("light_0" + (int)rand + ".jpg");
    }
    
    // 3: Random filter on background
    if (random(1) < 0.25) {
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
    
    // 4: Form 1
    Form form1 = new Form(width, height, width/2, height/2);
    // blur
    if (random(1) < 0.6)
      form1.blur = random(8);
    // base rotation
    form1.baseRotation = (int)random(8) * 45;
    // blend mode (sparse)
    if (random(2) < 0.15) {
      println("f1: subtract");
      form1.blendmode = SUBTRACT;
    } else if (random(2) < 0.15) {
      println("f1: exclusion");
      form1.blendmode = EXCLUSION;
    }
    // pick # generations
    form1.genStart = (int)random(2);
    form1.genEnd = form1.genStart + (int)random(2) + 1;
    println("f1:: genStart: " + form1.genStart + " // genEnd: " + form1.genEnd);
    
    
    // trackCenters
    // TODO: per generation toggle
  //public boolean[] trackCenters;
  
    
    // directed generations?
    //if (random(1) < 0.2) {
      //form1.directedGen = false;
      //form1.showShapes = false; // don't show shapes - super noisy
      //println("f1:: disable directed generations");
    //}
    
    // scale generations
    form1.scaleGeneration = 0.5*random(1) + 0.8;
    // offset generations
    form1.offsetGeneration = 0.5*random(1) + 0.5;
    println("f1:: scaleGen: " + form1.scaleGeneration + " // offsetGen: " + form1.offsetGeneration);
    // shapes
    form1.shapeCount = (int)random(9)+3; // at least 3, at most 12
    if (random(1) < 0.4) {
      // drop circular shapes
      form1.shapeSides = (int)random(12); 
    }
    // shape radius
    form1.shapeRadius = 0.5*random(1)+0.05;
    // shape offset
    form1.shapeOffset = 0.1*random(1)+0.1;
    println("f1:: rad: " + form1.shapeRadius + " // off: " + form1.shapeOffset);
    form1.shapeRotation = (int)random(8)*45;
    // randomly hide shapes
    if (random(1) < 0.25) {
      form1.showShapes = false;
      println("f1:: hide shapes");
    }
    form1.shapeWeight = 6.0*random(1)+0.5;
    form1.shapeOpacity = 0.5*random(1) + 0.5;
    println("f1:: shapeWeight: " + form1.shapeWeight + " // opa: " + form1.shapeOpacity);
      
    
/*    
  // == shape style ==
  public color shapeColor = #bbeaf7;
  public color shapeFillColor = #ffffff;
  public float shapeFillOpacity = 0.0;

  // == centers style ==
  public boolean showCenters = false;
  public color centerStrokeColor = #ffffff;
  public float centerStrokeWeight = 12.0;
  public float centerStrokeOpacity = 1.0;

  // == network style ==
  public boolean showNetwork = false;
  public color networkStrokeColor = #eeeeee;
  public float networkStrokeWeight = 2.0;
  public float networkStrokeOpacity = 0.8;
    */
    
    // bias colors
//    form1.shapeColor = darkBack ? color(random(40)+240) : color(random(40));

    
    //backbone.shapeRadius = rad;
    //backbone.shapeOffset = off;
    //backbone.showCenters = false;
    //backbone.showNetwork = false;
    //backbone.networkStrokeColor = #bbeaf7;
    //backbone.networkStrokeWeight = 2.0;
    //backbone.networkStrokeOpacity = 0.9;
    
    
    //backbone.shapeWeight = 2;
    //backbone.blur = 4;
    forms.add(form1);
    

    // circle container
    //Form form = new Form(width, height, width/2, height/2);
    //form.genStart = 0;
    //form.genEnd = 0;
    //form.shapeCount = 1;
    //form.offsetGeneration = 0;
    //form.scaleGeneration = 1.04;
    //form.shapeRadius = 0.73;
    //form.shapeWeight = 8.0;
    //form.shapeOpacity = 1.0;
    //form.shapeColor = #ffffff;
    //form.showCenters = false;
    //form.showNetwork = false;
    //form.shapeFillOpacity = 0.4;
    //form.shapeFillColor = #000000;
    //form.blur = 2;
    //forms.add(form);

/*
  fl//oat rad = 0.140;
  fl//oat off = 0.140;
*/

    
    //// network
    //Form net = new Form(width, height, width/2, height/2);
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