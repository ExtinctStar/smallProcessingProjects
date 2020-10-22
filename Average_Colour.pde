// Goal: Create a Program that will take in a "photo" as input and return the colour that will most closesly represent the given colours in the photo.
// Example: Given a photo a lush, green, forest, the colour that will be returned is a shade of green that is the mean of all shades of green in the photo.

float rAvg;
float gAvg;
float bAvg;
int pCount;

PImage tree;

void setup(){
  //640, 426 -> 1280, 426
  size(640, 426);
  //size(displayWidth, displayHeight);
  //surface.setResizable(true);
  background(0);
  
  tree = loadImage("trees.jpg");

}

void draw(){ 
  //background(0);
  //image(tree, 0, 0);
  
  loadPixels();
  tree.loadPixels();
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
      //float d = dist(x, y, width/2, height/2);
      int index = x+y*width;
      float r = red(tree.pixels[index]);
      float g = green(tree.pixels[index]);
      float b = blue(tree.pixels[index]);

      pixels[index] = color(r, g, b);
      

      //get color value at each point
      //if (x == 0 && y == 0) {
      //  pCount = 1;
      //  rAvg = red(pixels[index]);
      //  gAvg = green(pixels[index]);
      //  bAvg = blue(pixels[index]);
      //} else{
      //  pCount++;
      //  rAvg += red(pixels[index]);
      //  gAvg += green(pixels[index]);
      //  bAvg += blue(pixels[index]);
      //}    
    }
  }
  
  //rAvg /= pCount;
  //gAvg /= pCount;
  //bAvg /= pCount;
  
  //for(int x = width/2; x < width; x++){
  //  for(int y = 0; y < height; y++){
  //    //float d = dist(x, y, width/2, height/2);
  //    int index = x+y*width;

  //    pixels[index] = color(rAvg, gAvg, bAvg);
      
  //  }
  //}
  tree.updatePixels();
  updatePixels();
  
}
