import java.lang.Math;

ArrayList<Fruit> fruitList;
Fruit displayFruit; // the one that doesn't fall and shows you what will drop next
int type;
boolean displayed;
boolean startPage = true;
boolean modePage; //selects the modes
boolean winPage; // winning and congrats
boolean losePage; // failing and results
boolean regularMode; // normal play with score
boolean timerMode; // certain time restraints
boolean smallMode; // box size restaints
PFont f;
int time = 0;

void setup() {
  size(800,1000);
  background(196,164,132);
  fruitList = new ArrayList<Fruit>();
  type = (int) (Math.random() * 5);
  f = createFont("Monospaced",100,true);
}

void draw() {
  if (startPage){
    fill(204, 85, 0);
    textFont(f,100);
    text("Suika Game!!!",20,150);
    Button play = new Button(200,600,loadShape("watermelon.svg"),400,"Press to Play",20,color(100,100,100));
    ArrayList<Fruit> startDisplay = new ArrayList<Fruit>();
    if (!displayed){
      displayed = true;
      for (int i = 0; i < 10; i++){
        if (i < 7){
          startDisplay.add(new Fruit(10*(float)Math.pow(i,2)+30*i+115,300,i));
        }
        else{
          startDisplay.add(new Fruit(10*(float)Math.pow(i,2)+20*i-415,500,i));
        }
      }
    }
    for (int i = 0; i < startDisplay.size(); i++) {
      startDisplay.get(i).display();
    }
    play.display();
    play.click();
    if (play.clicked){
      startPage = false;
      displayed = false;
      regularMode = true;
    }
  }
  if (modePage){
    
  }
  if (winPage){
    textFont(f,100);
    text("You Win Kinda",100,150);
  }
  if (losePage){
    textFont(f,100);
    text("You Lose",100,150);
  }
  if (regularMode){
    if (mousePressed && mouseButton == LEFT && time >= 25) {
      fruitList.add(displayFruit);
      type = (int) (Math.random() * 5);
      displayFruit = new Fruit(mouseX, 150, type);
      time = 0;
    }
    time++;
    frameRate(30);
    background(196,164,132);
    fill(255,255,224);
    // The x of box is bounded 150 to 650 on outer and 160 to 640 on inner
    // The y on top is 150 and ends at 950 inner or 960 outer at the bottom
    rect(150,150,10,800);
    rect(640,150,10,800);
    rect(150,950,500,10);
    for (int i = 0; i < fruitList.size(); i++) {
      Fruit f = fruitList.get(i);
      PVector gravity = new PVector(0, f.mass*.3);
      f.applyForce(gravity);
      f.move();
      f.bounce();
      for (int j = i; j < fruitList.size(); j++) {
        Fruit g = fruitList.get(j);
        if (!f.equals(g)) {
          if (f.location.dist(g.location) < f.radius + g.radius) {
            if (f.type==g.type) {
              f.merge(g);
            } else {
              f.collide(g);
            }
          }
        }
        f.display();
        if (f.location.y < 150){
          losePage = true;
        }
      }
    }
    displayFruit = new Fruit(mouseX, 160, type);
    displayFruit.bounce();
    displayFruit.display();
    if (timerMode){
      
    }
    if (smallMode){
      
    }
  }
}
