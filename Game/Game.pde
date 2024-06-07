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
Scoreboard currentBoard;
PFont f;
int time = 0;

void setup() {
  size(800,1000);
  background(196,164,132);
  fruitList = new ArrayList<Fruit>();
  type = (int) (Math.random() * 5);
  f = createFont("Monospaced",100,true);
  currentBoard = new Scoreboard();
}

void draw() {
  if (startPage){
    fill(204, 85, 0);
    textFont(f,100);
    text("Suika Game!!!",20,150);
    Button modeSwitch = new Button(200,600,loadShape("watermelon.svg"),400,240,800,"Press to Select Mode",30,color(255,255,255));
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
    modeSwitch.display();
    modeSwitch.click();
    if (modeSwitch.clicked){
      startPage = false;
      displayed = false;
      modePage = true;
    }
  }
  if (modePage){
      if (time > 30){
        background(196,164,132);
        Button regularModeSwitch = new Button(200,-50,loadShape("watermelon.svg"),400,200,150,"Press to Select Regular Mode",30,color(255,255,255));
        regularModeSwitch.display();
        regularModeSwitch.click();
        if (regularModeSwitch.clicked){
          modePage = false;
          regularMode = true;
          time = 0;
         }
        Button timerModeSwitch = new Button(200,300,loadShape("watermelon.svg"),400,200,500,"Press to Select Timer Mode",30,color(255,255,255));
        timerModeSwitch.display();
        timerModeSwitch.click();
        if (timerModeSwitch.clicked){
          modePage = false;
          timerMode = true;
          regularMode = true;
          time = 0;
        }
        Button smallModeSwitch = new Button(200,650,loadShape("watermelon.svg"),400,200,850,"Press to Select Small Mode",30,color(255,255,255));
        smallModeSwitch.display();
        smallModeSwitch.click();
        if (smallModeSwitch.clicked){
          modePage = false;
          smallMode = true;
          regularMode = true;
          time = 0;
        }
      }
      time++;
  }
  if (winPage){
    textFont(f,100);
    text("You Kinda Win",100,150);
  }
  if (losePage){
    textFont(f,100);
    text("You Kinda Lose",100,150);
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
              currentBoard.addScore(f.type);
            } else {
              f.collide(g);
            }
          }
        }
        if (f.location.y < 150){
          losePage = true;
        }
      }
      f.display();
    }
    currentBoard.display();
    displayFruit = new Fruit(mouseX, 160, type);
    displayFruit.bounce();
    if (time >= 25) {
      displayFruit.display();
    }
    if (timerMode){
      
    }
    if (smallMode){
      
    }
  }
}
