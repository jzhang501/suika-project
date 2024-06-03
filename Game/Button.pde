class Button{
  
  PVector location;
  PShape shape;
  int size;
  String text;
  int fontSize;
  color c;
  boolean clicked;
  PFont f;
  
  Button(int x, int y, PShape shape, int size, String text, int fontSize, color c){
    this.location = new PVector(x,y);
    this.shape = shape;
    this.text = text;
    this.size = size;
    this.c = c;
  }
  
  void click(){
    if (mousePressed == true && mouseButton == LEFT){
      clicked = true;
    }
  }
  
  void display(){
    fill(c);
    shape(shape, location.x, location.y, size, size);
    f = createFont("Monospaced",100,true);
  }
  
}
