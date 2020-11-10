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
  }
  
  void drawBorder(){
    stroke(0);
    strokeWeight(2);
    noFill();
    rectMode(CORNERS);
    rect(x1-1, y1-1, x2-1, y2-1);
  }
  
  void keyMovement(){
    
  }
  
  void mouseMovement(){
    
  }
  
  void getPixels(){
    
  }
}//End Box Class
