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
int boxW = 80;

boolean centered;

void setup() {
  //640, 426 -> 1280, 426
  size(100, 100);
  source = loadImage("trees.jpg");
  //println("Source Width: " + source.width + " | Source Height: " + source.height);
  surface.setResizable(true);
  surface.setSize(source.width * 2, source.height);
  surface.setResizable(false);

  blankImg = createImage(source.width, source.height, RGB);
  boundBox = createImage(boxW, boxW, RGB);

  centered = false;
}

void draw() { 

  //Centers Display Window
  if (centered == false) {
    surface.setLocation(displayWidth/2 - width/2, displayHeight/2 - height/2);
    centered = true;
  }//end center

  //Averages _ALL_ Pixel Colours of Source Image
  loadPixels();
  source.loadPixels();
  blankImg.loadPixels();
  for (int x = 0; x < blankImg.width; x++) {
    for (int y = 0; y < blankImg.height; y++) {
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
      } else {
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

  for (int x = width/2; x < width; x++) {
    for (int y = blankImg.height / 2; y < blankImg.height; y++) {
      int index = x+y*width;

      pixels[index] = color(rAvg, gAvg, bAvg);
    }
  }//end drawing _ALL_ avg colour


  //Mouse Bounding Box
  //get bounding box to be copied to other side of screen (this is to be able to "see" the part of the image the mouse is hovering over)
  int xStart = constrain(pmouseX - boxW/2, 0, blankImg.width);
  int yStart = constrain(pmouseY - boxW/2, 0, blankImg.height);
  int xEnd = constrain(pmouseX + boxW/2, 0, blankImg.width);
  int yEnd = constrain(pmouseY + boxW/2, 0, blankImg.height);
  //println("xStart: " + xStart + " xEnd: " + xEnd + " yStart: " + yStart + " yEnd: " + yEnd);

  //Take all of the pixels inside bounding box and copy to boundBox.pixels[]
  //boundBox will paint all of its pixels to the Top Right of the Average colour of BB section
  int bbIndex = 0;
  boundBox.loadPixels();
  for (int x = xStart; x < xEnd; x++) {
    for (int y = yStart; y < yEnd; y++) {
      int index = x + y * width;

      boundBox.pixels[bbIndex] = pixels[index];
      bbIndex++;

      //get color value at each point
      if (x == xStart && y == yStart) {
        bbCount = 1;
        bb_rAvg = red(pixels[index]);
        bb_gAvg = green(pixels[index]);
        bb_bAvg = blue(pixels[index]);
      } else {
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

  for (int x = width/2; x < width; x++) {
    for (int y = 0; y < blankImg.height/2; y++) {
      int index = x+y*width;

      pixels[index] = color(bb_rAvg, bb_gAvg, bb_bAvg);
    }
  }//end drawing Bounding Box Average Colour


  int bbXOffset = 10;
  int bbYOffset = 30;
  int bbXStart = width/2 + bbXOffset;
  int bbXEnd = bbXStart + boxW;
  int bbYStart = bbYOffset;
  int bbYEnd = bbYStart + boxW;
  for (int x = bbXStart; x < bbXEnd; x++) {
    for (int y = bbYStart; y < bbYEnd; y++) {
      int index = x+y*width;

      pixels[index] = boundBox.pixels[bbIndex];
      bbIndex++;
    }
  }

  blankImg.updatePixels();
  updatePixels();

  fill(255);
  textSize(14);
  textAlign(LEFT, CENTER);

  int size_YLoc = (bbYStart + bbYEnd) / 2;
  //text("Size: " + boxW + " Pixels", (bbXStart + bbXEnd) / 2, bbYEnd + 10);  
  text("Size: " + boxW + " Pixels", bbXEnd + 10, size_YLoc);


  //Draw Box Borders 
  stroke(0);
  strokeWeight(2);
  noFill();
  rectMode(CORNERS);
  rect(xStart-1, yStart-1, xEnd+1, yEnd+1);
  rect(bbXStart-1, bbYStart-1, bbXEnd+1, bbYEnd+1);

  //Show Colour Info and Bounding Box Size
  //text(" | Size of Bounding Box: " + boxW + " Pixels", 5, height - 5);

  rgbMenu(blankImg.width, 0, bb_rAvg, bb_gAvg, bb_bAvg);
  rgbMenu(blankImg.width, height - 20, rAvg, gAvg, bAvg);
  //End Draw Menus
}

void centerWindow() {
  if (frame != null && centered == false) {
    frame.setLocation(displayWidth/2 - width/2, displayHeight/2 - height/2);
    centered = true;
  }
}

void rgbMenu(int x, int y, float r, float g, float b) {
  int xEnd = width;
  int yEnd = y + 20;

  stroke(0);
  strokeWeight(1);
  fill(255);
  rectMode(CORNERS);
  rect(x, y, xEnd, yEnd);

  rgb_DrawList(x, y, r, g, b);
}

void rgb_DrawList(int x, int y, float r, float g, float b) { 
  fill(0);
  textSize(12);
  textAlign(LEFT, TOP);

  color rgb = color(r, g, b);
  text("R: " + round(r) + " | G: " + round(g) + " | B: " + round(b) +
    "|| Hex: " + hex(rgb, 6), x + 5, y + 3);
}
