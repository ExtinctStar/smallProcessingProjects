PImage source;
PImage blankImg;
boolean centered;

Box boxControl;

void setup(){
  size(100, 100);
  source = loadImage("trees.jpg");
  surface.setResizable(true);
  surface.setSize(source.width * 2, source.height);
  surface.setResizable(false);
  
  blankImg = createImage(source.width, source.height, RGB);
  
  int boxSize = 80;
  boxControl = new Box(boxSize);
  
  centered = false;
}//end setup()


void draw(){
  background(0);
  
  centerWindow();
  
  getPixels(0, 0, blankImg.width, blankImg.height);
  color avgColour = findAvgColour(0, 0, blankImg.width, blankImg.height);
  //println("R: " + red(avgColour) + " G: " + green(avgColour) + " B: " + blue(avgColour));
  drawAvgColour(width/2, blankImg.height/2, width, blankImg.height, avgColour);
  
  boxControl.getPixels();
  color boxAvgColour = boxControl.avgColour();
  drawAvgColour(width/2, 0, width, blankImg.height/2, boxAvgColour);
  
  if(mousePressed){
    boxControl.mouseMovement();
  }
  //boxControl.drawBorder();
  //boxControl.boxDraw(pmouseX, pmouseY);
  //boxControl.boxDraw(width/2 , height/2);
}//end draw()


void centerWindow(){
  if(centered == false){
    surface.setLocation(displayWidth/2 - width/2, displayHeight/2 - height/2);
    centered = true;
  }
}//End centerWindow()


void keyPressed(){
  boxControl.keyMovement();
}//End keyPressed()


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
    }
  }
  
  blankImg.updatePixels();
  updatePixels();
}//end getPixels()


color findAvgColour(int _x1, int _y1, int _x2, int _y2){
  loadPixels();
  
  int count = 0;
  int index = _x1+_y1*width;
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
    }
  }
  updatePixels();
}//end drawAvgColour()
