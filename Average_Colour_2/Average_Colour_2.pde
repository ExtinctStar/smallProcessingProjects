PImage source;
PImage blankImg;
boolean centered;
PFont UIFont;

int windowSize = 300;
int boxSize;

Box boxControl;
Button importButton;

String imageFileName = "trees.jpg";

void setup(){
  size(100, 100);
  source = loadImage(imageFileName);
  surface.setResizable(true);
  surface.setSize(source.width + windowSize, source.height);
  surface.setResizable(false);
  
  blankImg = createImage(source.width, source.height, RGB);
  
  boxSize = 80;
  boxControl = new Box(boxSize);

  importButton = new Button();
  
  centered = false;
  
  UIFont = createFont("Arial Bold", 14);
}//end setup()


void draw(){
  background(0);
  
  centerWindow();
  
  if(importButton.isButtonClick() == false){
    getPixels(0, 0, blankImg.width, blankImg.height);
    color avgColour = findAvgColour(0, 0, blankImg.width, blankImg.height);
    drawAvgColour(blankImg.width, blankImg.height/2, width, blankImg.height, avgColour);
    
    color boxAvgColour = boxControl.avgColour();
    drawAvgColour(blankImg.width, 0, width, blankImg.height/2, boxAvgColour);
    
    if(mousePressed){
      boxControl.mouseMovement();
    }//if
    
    rgbMenu(blankImg.width, height - 20, avgColour);
    rgbMenu(blankImg.width, 0, boxAvgColour);
  
    boxControl.boxGetPixels();
    boxControl.copyAt(width - boxSize - 10, 30);
    
    importButton.drawButton();
    if(importButton.isMouseHover()){
      importButton.toggle();
    }//if    
  } else {
    fill(255);
    textAlign(LEFT, TOP);
    textFont(UIFont);
  
    text("Press any key to continue...", 0, 0);
    //Check if key is pressed after Image Selection, then resume program and reset Box 
    if(keyPressed){
      importButton.resume();
      boxControl.updatePosition(blankImg.width/2, blankImg.height/2);
    }//if
  }//if_else
}//end draw()
/***********************************************************************************/
/***********************************************************************************/

void mouseClicked(){
  if(importButton.isMouseHover()){
    importButton.pause();
    selectInput("Select an Image to Import:", "processFile");
  }//if
}//end mouseClicked()


void processFile(File selection){
  if(selection == null){
    println("Window was closed or the user hit cancel.");
  } else {
    imageFileName = selection.getAbsolutePath();
    println("User selected " + imageFileName);
    source = loadImage(imageFileName);
    source.resize(source.width, source.height);

    surface.setResizable(true);
    surface.setSize(source.width + windowSize, source.height);
    surface.setResizable(false);
    
    blankImg.resize(source.width, source.height);
    
    importButton.updatePos();
    
    centered = false;
  }//if_else
}//end processFile


void keyPressed(){
  boxControl.keyMovement();
}//End keyPressed()


void centerWindow(){
  if(centered == false){
    surface.setLocation(displayWidth/2 - width/2, displayHeight/2 - height/2);
    centered = true;
  }//if
}//End centerWindow()


void getPixels(int _x1, int _y1, int _x2, int _y2){
  loadPixels();
  source.loadPixels();
  blankImg.loadPixels();
  
  for(int x = _x1; x < _x2; x++){
    for(int y = _y1; y < _y2; y++){
      int index = x+y*width;
      int imageIndex = x+y*blankImg.width;
      
      blankImg.pixels[imageIndex] = source.pixels[imageIndex];
      pixels[index] = blankImg.pixels[imageIndex];
    }//x
  }//y
  
  blankImg.updatePixels();
  updatePixels();
}//end getPixels()


color findAvgColour(int _x1, int _y1, int _x2, int _y2){
  loadPixels();
  
  int count = 0;
  int index = _x1+_y1*blankImg.width;
  float rAvg = red(pixels[index]);
  float gAvg = green(pixels[index]);
  float bAvg = blue(pixels[index]);  
  
  for(int x = _x1; x < _x2; x++){
    for(int y = _y1; y < _y2; y++){
      index = x+y*width;
      
      count++;
      rAvg += red(pixels[index]);
      gAvg += green(pixels[index]);
      bAvg += blue(pixels[index]);
    }//y
  }//x
  updatePixels();
  
  rAvg /= count;
  gAvg /= count;
  bAvg /= count;
  
  color rgb = color(rAvg, gAvg, bAvg);
  
  return rgb;
}//end findAvgColour()


void drawAvgColour(int _x1, int _y1, int _x2, int _y2, color _rgb){
  loadPixels();
  for (int x = _x1; x < _x2; x++){
    for (int y = _y1; y < _y2; y++){
      int index = x+y*width;
      
      pixels[index] = _rgb;
    }//x
  }//y
  updatePixels();
}//end drawAvgColour()


void rgbMenu(int _x1, int _y1, color _rgb) {
  int _x2 = width;
  int _y2 = _y1 + 20;

  stroke(0);
  strokeWeight(1);
  fill(255);
  rectMode(CORNERS);
  rect(_x1, _y1, _x2, _y2);

  rgbDrawList(_x1, _y1, _rgb);
}//end rgbMenu()


void rgbDrawList(int x, int y, color _rgb) { 
  fill(0);
  textAlign(LEFT, TOP);
  textFont(UIFont);
  
  text("R: " + round(red(_rgb)) + " | G: " + round(green(_rgb)) + " | B: " + round(blue(_rgb)) +
    " || Hex: " + hex(_rgb, 6), x + 5, y + 3);
}//end rgbDrawList()
