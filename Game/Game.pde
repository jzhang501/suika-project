import java.lang.Math;
import processing.core.*;

ArrayList<Fruit> fruitList;
Fruit displayFruit; // the one that doesn't fall and shows you what will drop next
int type;
boolean displayed;
boolean startPage = true;
boolean modePage; //selects the modes
boolean endPage; // winning and congrats
boolean regularMode; // normal play with score
boolean timerMode; // certain time restraints
boolean smallMode; // box size restaints
Scoreboard currentBoard;
Stopwatch currentTime;
PFont f;
int time = 0;
int bot = 0;
final int delay = 25; // default 25

void setup() {
  frameRate(30);
  size(800,1000);
  background(234, 202, 169);
  fruitList = new ArrayList<Fruit>();
  type = (int) (Math.random() * 5);
  f = createFont("Monospaced",100,true);
  currentBoard = new Scoreboard();
  currentTime = new Stopwatch();
}

void draw() {
  if (startPage){
    fill(204, 85, 0);
    textFont(f,100);
    text("Suika Game!!!",20,150);
    Button modeSwitch = new Button(200,600,loadShape("watermelon.svg"),400,240,800,"Press to Select Mode",30, 255, color(150,255,150));
    modeSwitch.hoverEffect();
    ArrayList<Fruit> startDisplay = new ArrayList<Fruit>();
    if (!displayed){
      background(234, 202, 169);
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
      if (time > 15){
        background(234, 202, 169);
        Button regularModeSwitch = new Button(150,75,500,150,200,160,"Press to Select Regular Mode",30, 0, color(150,255,150));
        regularModeSwitch.hoverEffect();
        text("You can play to get as much as you can",130,250);     
        regularModeSwitch.display();
        regularModeSwitch.click();
        if (regularModeSwitch.clicked){
          modePage = false;
          regularMode = true;
          time = 0;
         }
        Button timerModeSwitch = new Button(150,425,500,150,210,510,"Press to Select Timer Mode",30, 0, color(150,255,150));
        timerModeSwitch.hoverEffect();
        text("You have 90 seconds to get as much as you can",75,600);
        timerModeSwitch.display();
        timerModeSwitch.click();
        if (timerModeSwitch.clicked){
          modePage = false;
          timerMode = true;
          regularMode = true;
          time = 0;
        }
        Button smallModeSwitch = new Button(150,775,500,150,220,860,"Press to Select Small Mode",30, 0, color(150,255,150));
        smallModeSwitch.hoverEffect();
        text("You have a smaller space to get as much as you can",45,950);
        smallModeSwitch.display();
        smallModeSwitch.click();
        if (smallModeSwitch.clicked){
          modePage = false;
          smallMode = true;
          regularMode = true;
          time = 0;
        }
        Button exitSwitch = new Button(50, 50,75,50,55,80,"Exit",30, 0, color(150,255,150));
        exitSwitch.hoverEffect();
        exitSwitch.display();
        exitSwitch.click();
        if (exitSwitch.clicked){
          startPage = true;
          modePage = false;
          time = 0;
        }
      }
      time++;
  }
  if (endPage){
    background(234, 202, 169);
    fill(204, 85, 0);
    textFont(f,50);
    text("Better luck next time!",70,150);
    text("You got a score of " + currentBoard.score + "!",80,300);
    text("Don't lose again!",135,450);
    Button playAgainSwitch = new Button(200,600,loadShape("watermelon.svg"),400,250,800,"Press to Play Again",30, 255, color(150,255,150));
    playAgainSwitch.hoverEffect();
    playAgainSwitch.display();
    playAgainSwitch.click();
    if (playAgainSwitch.clicked){
      modePage = true;
      endPage = false;
      fruitList.clear();
      currentBoard.clear();
      currentTime.clear();
    }
  }
  if (regularMode){
    if (mousePressed && mouseButton == LEFT && time >= delay) {
      fruitList.add(displayFruit);
      type = (int) (Math.random() * 5);
      displayFruit = new Fruit(mouseX, 150, type);
      time = 0;
    }
    time++;
    frameRate(30);
    currentTime.addSecond();
    background(234, 202, 169);
    fill(255,255,224);
    // The x of box is bounded 150 to 650 on outer and 160 to 640 on inner
    // The y on top is 150 and ends at 950 inner or 960 outer at the bottom

   if (smallMode){
     rect(150,150,10,500);
     rect(640,150,10,500);
     rect(150,650,500,10);
     bot = 650;
   }
   else{
     rect(150,150,10,800);
     rect(640,150,10,800);
     rect(150,950,500,10);
     bot = 950;
   }
   
    // all fruits
    for (int i = 0; i < fruitList.size(); i++) {
      Fruit f = fruitList.get(i);
      PVector gravity = new PVector(0, f.mass*.3);
      f.applyForce(gravity);
      f.move();
      f.bounce(bot);
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
          regularMode = false;
          smallMode = false;
          timerMode = false;
          endPage = true;
        }
      }
      f.display();
    }
    currentBoard.display();
    currentTime.display();
    displayFruit = new Fruit(mouseX, 160, type);
    displayFruit.bounce(bot);
    if (time >= delay) {
      displayFruit.display();
    }
    
    if (timerMode){
      if (currentTime.ticks/30 > 90){
          regularMode = false;
          smallMode = false;
          timerMode = false;
          endPage = true;
      }
    }
  }
}
