// Goal: Create a Program that will take in a "photo" as input and return the colour that will most closesly represent the given colours in the photo.
// Example: Given a photo a lush, green, forest, the colour that will be returned is a shade of green that is the mean of all shades of green in the photo.

float rAvg;
float gAvg;
float bAvg;
int pCount;

float bb_rAvg;
float bb_gAvg;
float bb_bAvg;
int bbCount;

PImage source;
PImage blankImg;
PImage boundBox;
int imgW = 80;

float menuSize = 20;

void setup(){
  //640, 426 -> 1280, 426
  size(1280, 446);
  //size(displayWidth, displayHeight);
  //surface.setResizable(true);
  //background(255);
  
  source = loadImage("trees.jpg");
  blankImg = createImage(source.width, source.height, RGB);
  boundBox = createImage(imgW, imgW, RGB);

}

void draw(){ 
  
  loadPixels();
  source.loadPixels();
  blankImg.loadPixels();
  for(int x = 0; x < blankImg.width; x++){
    for(int y = 0; y < blankImg.height; y++){
      int index = x+y*width;
      int imageIndex = x + y*blankImg.width;
      
      blankImg.pixels[imageIndex] = source.pixels[imageIndex];
      pixels[index] = blankImg.pixels[imageIndex];

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
    for(int y = blankImg.height / 2; y < blankImg.height; y++){
      int index = x+y*width;

      pixels[index] = color(rAvg, gAvg, bAvg);
    }
  }
  
  //get bounding box to be copied to other side of screen (this is to be able to "see" the part of the image the mouse is hovering over)
  int xStart = constrain(pmouseX - imgW/2, 0, blankImg.width);
  int yStart = constrain(pmouseY - imgW/2, 0, blankImg.height);
  int xEnd = constrain(pmouseX + imgW/2, 0, blankImg.width);
  int yEnd = constrain(pmouseY + imgW/2, 0, blankImg.height);
  println("xStart: " + xStart + " xEnd: " + xEnd + " yStart: " + yStart + " yEnd: " + yEnd);
  
  //Take all of the pixels inside bounding box and copy to boundBox.pixels[]
  //boundBox will paint all of its pixels to the Top Right of the Average colour of BB section
  int bbIndex = 0;
  boundBox.loadPixels();
  for(int x = xStart; x < xEnd; x++){
    for(int y = yStart; y < yEnd; y++){
      int index = x + y * width;
      
      boundBox.pixels[bbIndex] = pixels[index];
      bbIndex++;
      
      //get color value at each point
      if (x == xStart && y == yStart) {
        bbCount = 1;
        bb_rAvg = red(pixels[index]);
        bb_gAvg = green(pixels[index]);
        bb_bAvg = blue(pixels[index]);
      } else{
        bbCount++;      
        bb_rAvg += red(pixels[index]);
        bb_gAvg += green(pixels[index]);
        bb_bAvg += blue(pixels[index]);
      }   
    }
  }
  bbIndex = 0;
  boundBox.updatePixels();
  
  bb_rAvg /= bbCount;
  bb_gAvg /= bbCount;
  bb_bAvg /= bbCount;
  
  for(int x = width/2; x < width; x++){
    for(int y = 0; y < blankImg.height/2; y++){
      int index = x+y*width;

      pixels[index] = color(bb_rAvg, bb_gAvg, bb_bAvg);
    }
  }
  
  int bbOffset = 10;
  int bbXStart = width/2 + bbOffset;
  int bbXEnd = bbXStart + imgW;
  int bbYStart = bbOffset;
  int bbYEnd = bbYStart + imgW;
  for(int x = bbXStart; x < bbXEnd; x++){
    for(int y = bbYStart; y < bbYEnd; y++){
      int index = x+y*width;
      
      pixels[index] = boundBox.pixels[bbIndex];
      bbIndex++;
    }
  }
  
  blankImg.updatePixels();
  updatePixels();
    
  stroke(0);
  strokeWeight(2);
  noFill();
  rectMode(CORNERS);
  rect(xStart-1, yStart-1, xEnd+1, yEnd+1);
  rect(bbXStart-1, bbYStart-1, bbXEnd+1, bbYEnd+1);
  
  fill(255);
  noStroke();
  rect(0, height - menuSize, width, height);
  
  //Show Colour Info and Bounding Box Size
  
  textSize(12);
  fill(0);
  text("Avg of Whole Source || R: " + round(rAvg) + " | G: " + round(gAvg) + " | B: " + round(bAvg) + 
        " || Avg of Bounding Box || R: " + round(bb_rAvg) + " | G: " + round(bb_gAvg) + " | B: " + round(bb_bAvg) + 
        " | Size of Bounding Box: " + imgW + " Pixels", 5, height - 5);
}
