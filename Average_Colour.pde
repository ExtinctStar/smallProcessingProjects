// Goal: Create a Program that will take in a "photo" as input and return the colour that will most closesly represent the given colours in the photo.
// Example: Given a photo a lush, green, forest, the colour that will be returned is a shade of green that is the mean of all shades of green in the photo.
// 
// Plan of Action: 1) Base case, reduce colours on photo to pure black(0) and white(255) by increasing the contrast and estimating the brightness to b and w.
//                 2) Pure RGB, reduce colours on to photo to pure red(255, 0, 0), green(0, 255, 0), and blue(0, 0, 255).
//                 3) Rainbow!, reduce colours on photo to all pure colours of the rainbow (given source of colour values), i.e. ROYGBIV.
//                 4) Need to classify all colours as a "type" of colour? for example, tan to dark brown are browns, dark to light green are green, determine ratios of colours.
//                 5) Find the biggest "type" of colour in photo (most pixels of a type), then average those pixel colours together to get the final colour.
//                 6) Display Final Colour (Next to or as a border to original photo.

float rAvg;
float gAvg;
float bAvg;

int pCount;

void setup(){
  size(1200, 600);
  //size(displayWidth, displayHeight);
  //surface.setResizable(true);
  background(0);
  
  //loadPixels();
  //for(int i = 0; i < pixels.length; i++){
  //  pixels[i] = color(random(100, 230), 0, random(50, 100)); 
  //}
  //updatePixels();
  
  loadPixels();
  for(int x = 0; x < width/2; x++){
    for(int y = 0; y < height; y++){
      //float d = dist(x, y, width/2, height/2);
      int index = x+y*width;
      
      //pixels[index] = color(0, 0, 0);
      if(x > width/4) pixels[index] = color(0, 0, 0);
      if(x < width/4) pixels[index] = color(255);
      
      //get color value at each point
      if (x == 0 && y == 0) {
        pCount = 1;
        rAvg = red(pixels[index]);
        gAvg = green(pixels[index]);
        bAvg = blue(pixels[index]);
      } else{
        pCount++;
        rAvg += red(pixels[index]) / pCount;
        gAvg += green(pixels[index]) / pCount;
        bAvg += blue(pixels[index]) / pCount;
      }
      
      //if(x > width/2) pixels[index] = color(rAvg, gAvg, bAvg);
      
    }
  }
  
  for(int x = width/2; x < width; x++){
    for(int y = 0; y < height; y++){
      //float d = dist(x, y, width/2, height/2);
      int index = x+y*width;

      pixels[index] = color(rAvg, gAvg, bAvg);
      
    }
  }
  updatePixels();

}

void draw(){ 
  //background(rAvg, gAvg, bAvg);
  
}
