/************************************************************************************
 * Button Object Class
 * @author Cody Martin
 * Object used as the Import Button to import an image to process
 * @params x1, y1, x2, y2: Values that hold the coordinates of the Button
 * @param buttonString: The text that displays on the button
 * @param mouseHover: Holds if the mouse is hovering within the bounds of the Button
 * @param buttonClick: Holds if the button has been Clicked and returns false after
 *                     User selects an image to import
 * @param curve: Value for the level of curvature of the corners of the rectangle
 *               comprising the body of the button
 ***********************************************************************************/
class Button{
  int x1, y1, x2, y2;
  String buttonString; 
  boolean mouseHover;
  boolean buttonClick;
  int curve;
  
  
  Button(){
    updatePos();
    
    buttonString = "Import Button";
    
    mouseHover = false;
    buttonClick = false;
    
    curve = 7;
  }//end Constructor
  
  
  void updatePos(){
    int xWidth = 100;
    int yHeight = 20;
    int xOffset = 10;
    int yOffset = 30;
    
    x1 = width - xWidth - xOffset;
    y1 = height - yHeight - yOffset;
    x2 = width - xOffset;
    y2 = height - yOffset;
  }//end updatePos()
  
  
  void drawButton(){
    stroke(255);
    strokeWeight(3);
    fill(24, 171, 204);//Dark Tealish
    rectMode(CORNERS);
    rect(x1, y1, x2, y2, curve);
    
    fill(0);
    textAlign(LEFT, TOP);
    fittedText("Import Image", UIFont, x1+5, y1+1, x2-4, y2-2);
  }//end drawButton()
  
  
  boolean isMouseHover(){
    if(mouseX > x1 && mouseX < x2 && mouseY > y1 && mouseY < y2)
      mouseHover = true;
    else mouseHover = false;
    
    return mouseHover;
  }//end isMouseHover()
  
  
  void toggle(){
    stroke(150);
    strokeWeight(1);
    fill(200);
    rectMode(CORNERS);
    rect(x1, y1, x2, y2, curve);
    
    fill(255);
    textAlign(LEFT, TOP);
    fittedText("Import Image", UIFont, x1+5, y1+1, x2-4, y2-2);
  }//end toggle()
  
  
  boolean isButtonClick(){
    return buttonClick;
  }//end isButtonClick()
  
  
  void pause(){
    buttonClick = true;
  }//end pause()
  
  
  void resume(){
    buttonClick = false;
  }//end resume()
}//end Button Class


//REWRITE AND STUDY
public void fittedText(String text, PFont font, float posX, float posY, float fitX, float fitY)
{
  textFont(font);
  textSize(min(font.getSize()*(abs(fitX - posX))/textWidth(text), abs(fitY - posY)));
  text(text, posX, posY);
}//end fittedText
