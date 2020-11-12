class Box{
  PImage boundBox;
  int size, halfSize;
  int x1, y1, x2, y2;
  int[] boxCenter = new int[2];
  
  int xFactor, yFactor;
  
  Box(int _size){
    size = _size;
    halfSize = size / 2;
    
    //Set Default Values
    boxCenter[0] = blankImg.width / 2;
    boxCenter[1] = blankImg.height / 2;
    
    updatePosition(boxCenter[0], boxCenter[1]);
    
    xFactor = 0;
    yFactor = 0;
    
    boundBox = createImage(size, size, RGB);
  }//end Constructor
  
  
  void updatePosition(int xCenter, int yCenter){
    x1 = constrain(xCenter - halfSize + xFactor, 0, blankImg.width);
    y1 = constrain(yCenter - halfSize + yFactor, 0, blankImg.height);
    x2 = constrain(xCenter + halfSize + xFactor, 0, blankImg.width);
    y2 = constrain(yCenter + halfSize + yFactor, 0, blankImg.height);
  }//end updatePosition()
  
  
  void drawBorder(){
    stroke(0);
    strokeWeight(2);
    noFill();
    rectMode(CORNERS);
    rect(x1-1, y1-1, x2-1, y2-1);
  }//end drawBorder()
  
  
  void keyMovement(){
    int scale = 10;
    
    if(key == CODED){
      switch(keyCode){
        case LEFT:
          println("LEFT");
          if(xFactor > halfSize - boxCenter[0]){
            xFactor = constrain(xFactor - scale, halfSize - boxCenter[0], blankImg.width - boxCenter[0] - halfSize);
          }
          break;
        case UP:
          println("UP");
          if(yFactor > halfSize - boxCenter[1]){
            yFactor = constrain(yFactor - scale, halfSize - boxCenter[1], blankImg.height - boxCenter[1] - halfSize);
          }
          break;
        case RIGHT:
          println("RIGHT");
          if(xFactor < blankImg.width - boxCenter[0] - halfSize){
            xFactor = constrain(xFactor + scale, halfSize - boxCenter[0], blankImg.width - boxCenter[0] - halfSize);
          }
          break;
        case DOWN:
          println("DOWN");
          if(yFactor < blankImg.height - boxCenter[1] - halfSize){
            yFactor = constrain(yFactor + scale, halfSize - boxCenter[1], blankImg.height - boxCenter[1] - halfSize);
          }
          break;
      }//end switch
    }//end if
    
    updatePosition(boxCenter[0], boxCenter[1]);
  }//end keyMovement()
  
  
  void mouseMovement(){
    boxCenter[0] = constrain(pmouseX - xFactor, 0 - xFactor + halfSize, blankImg.width - xFactor - halfSize);
    boxCenter[1] = constrain(pmouseY - yFactor, 0 - yFactor + halfSize, blankImg.height - yFactor - halfSize);
    
    updatePosition(boxCenter[0], boxCenter[1]);
    
    //boxGetPixels();
  }//end mouseMovement()
  
  
  void boxGetPixels(){
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
    
    //drawBorder();
  }//end getPixels()
  
  
  color avgColour(){
    color boxAvgColour = findAvgColour(x1, y1, x2, y2);
    //println("R: " + red(boxAvgColour) + " G: " + green(boxAvgColour) + " B: " + blue(boxAvgColour));
    
    return boxAvgColour;
  }//end avgColour
}//End Box Class
