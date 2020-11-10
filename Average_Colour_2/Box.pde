class Box{
  PImage boundBox;
  int size, halfSize;
  int x1, y1, x2, y2;
  int[] boxCenter = new int[2];
  
  Box(int _size){
    size = _size;
    halfSize = size / 2;
    
    //Set Default Values
    boxCenter[0] = blankImg.width / 2;
    boxCenter[1] = blankImg.height / 2;
    
    x1 = boxCenter[0] - halfSize;
    y1 = boxCenter[1] - halfSize;
    x2 = boxCenter[0] + halfSize;
    y2 = boxCenter[1] + halfSize;
    
    boundBox = createImage(size, size, RGB);
  }//end Constructor
  
  
  void drawBorder(){
    stroke(0);
    strokeWeight(2);
    noFill();
    rectMode(CORNERS);
    rect(x1-1, y1-1, x2-1, y2-1);
  }//end drawBorder()
  
  
  void keyMovement(){
    
  }//end keyMovement()
  
  
  void mouseMovement(){
    boxCenter[0] = pmouseX;
    boxCenter[1] = pmouseY;
    
    x1 = constrain(boxCenter[0] - halfSize, 0, blankImg.width);
    y1 = constrain(boxCenter[1] - halfSize, 0, blankImg.height);
    x2 = constrain(boxCenter[0] + halfSize, 0, blankImg.width);
    y2 = constrain(boxCenter[1] + halfSize, 0, blankImg.height);
  }//end mouseMovement()
  
  
  void getPixels(){
    loadPixels();
    boundBox.loadPixels();
    
    int boxIndex = 0;
    for (int x = x1; x < x2; x++){
      for (int y = y1; y < y2; y++){
        int index = x+y*width;
        
        boundBox.pixels[boxIndex] = pixels[index];
        boxIndex++;
      }
    }
    
    boundBox.updatePixels();
    updatePixels();
    
    drawBorder();
  }//end getPixels()
  
  
  color avgColour(){
    color boxAvgColour = findAvgColour(x1, y1, x2, y2);
   println("R: " + red(boxAvgColour) + " G: " + green(boxAvgColour) + " B: " + blue(boxAvgColour));
    
    return boxAvgColour;
  }//end avgColour
}//End Box Class
