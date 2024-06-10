import java.lang.Math;

class Stopwatch{
  int seconds;
  int reg;
  
  Stopwatch(){
    seconds = 0;
  }
  
  void display(){
    fill(255,255,224);
    rect(610, 20, 150, 100, 10, 10, 10, 10);
    fill(0);
    text("Time:", 630, 60);
    text(seconds, 630, 100);
  }
  
  void addSecond(){
      seconds++;
  }
  
}
  
