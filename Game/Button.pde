class Button{
  
  PVector shapeLocation;
  PShape shape;
  int size;
  PVector textLocation;
  String text;
  int textSize;
  color c;
  PFont f;
  boolean clicked;
  
  Button(int xl, int yl, PShape shape, int size, int xt, int yt, String text, int textSize, color c){
    this.shapeLocation = new PVector(xl,yl);
    this.shape = shape;
    this.size = size;
    this.textLocation = new PVector(xt,yt);
    this.text = text;
    this.textSize = textSize;
    this.c = c;
    f = createFont("Arial",textSize,true);
  }
  
  void click(){
    if (mousePressed == true && mouseButton == LEFT){
      if ( mouseX >= shapeLocation.x && mouseX <= shapeLocation.x + size && mouseY >= shapeLocation.y && mouseY <= shapeLocation.y + size){
      clicked = true;
      }
    }
  }
  
  void display(){
    fill(c);
    shape(shape, shapeLocation.x, shapeLocation.y, size, size);
    textFont(f,textSize);
    text(text,textLocation.x, textLocation.y);
  }
  
}
