// Goal: Create a Program that will take in a "photo" as input and return the colour that will most closesly represent the given colours in the photo.
// Example: Given a photo a lush, green, forest, the colour that will be returned is a shade of green that is the mean of all shades of green in the photo.

float rAvg;
float gAvg;
float bAvg;
int pCount;

PImage tree;
PImage blankImg;

void setup(){
  //640, 426 -> 1280, 426
  size(1280, 426);
  //size(displayWidth, displayHeight);
  //surface.setResizable(true);
  background(0);
  
  tree = loadImage("trees.jpg");
  blankImg = createImage(640, 426, RGB);

}

void draw(){ 
  //background(0);
  //image(tree, 0, 0);
  
  loadPixels();
  tree.loadPixels();
  blankImg.loadPixels();
  for(int x = 0; x < blankImg.width; x++){
    for(int y = 0; y < blankImg.height; y++){
      int index = x+y*width;
      int imageIndex = x + y*blankImg.width;
      
      blankImg.pixels[imageIndex] = tree.pixels[imageIndex];
      pixels[index] = blankImg.pixels[imageIndex];
      
      //float b = brightness(tree.pixels[index]);
      //if (b > mouseX){
      //  pixels[index] = color(255);
      //}else{
      //  pixels[index] = color(0);
      //}
      
      //float d = dist(pmouseX, pmouseY, x, y);
      //float r = red(tree.pixels[index]);
      //float g = green(tree.pixels[index]);
      //float b = blue(tree.pixels[index]);
      //float factor = map(d, 0, 200, 1, 0);
      //pixels[index] = color(r*factor, g*factor, b*factor);
      

      //get color value at each point
      if (x == 0 && y == 0) {
        pCount = 1;
        rAvg = red(pixels[index]);
        gAvg = green(pixels[index]);
        bAvg = blue(pixels[index]);
      } else{
        pCount++;
        rAvg += red(pixels[index]);
        gAvg += green(pixels[index]);
        bAvg += blue(pixels[index]);
      }    
    }
  }
  
  rAvg /= pCount;
  gAvg /= pCount;
  bAvg /= pCount;
  
  for(int x = width/2; x < width; x++){
    for(int y = 0; y < height; y++){
      //float d = dist(x, y, width/2, height/2);
      int index = x+y*width;

      pixels[index] = color(rAvg, gAvg, bAvg);
      
    }
  }
  blankImg.updatePixels();
  //tree.updatePixels();
  updatePixels();
  
}
