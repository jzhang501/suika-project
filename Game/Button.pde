class Button{
  
  PVector shapeLocation;
  PShape shape;
  int size = 0;
  int l = 0;
  int w = 0;
  PVector textLocation;
  String text;
  int textSize;
  color c;
  PFont f;
  boolean clicked;
  boolean fill;
  
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
  
  Button(int xl, int yl, int l, int w, int xt, int yt, String text, int textSize, color c){
    this.shapeLocation = new PVector(xl,yl);
    shape = createShape(RECT, xl, yl, l, w);
    shape.setFill(color(255,226,130));
    this.l = l;
    this.w = w;
    this.textLocation = new PVector(xt,yt);
    this.text = text;
    this.textSize = textSize;
    this.c = c;
    f = createFont("Arial",textSize,true);
    fill = true;
  }
  
  void click(){
    if (mousePressed == true && mouseButton == LEFT){
      if ( mouseX >= shapeLocation.x && mouseX <= shapeLocation.x + l + size && mouseY >= shapeLocation.y && mouseY <= shapeLocation.y + w + size){
      clicked = true;
      }
    }
  }
  
  void display(){
    fill(c);
    if (fill){
      shape(shape);
    }
    else{
      shape(shape, shapeLocation.x, shapeLocation.y, size, size);
    }
    textFont(f,textSize);
    text(text,textLocation.x, textLocation.y);
  }
  
}
