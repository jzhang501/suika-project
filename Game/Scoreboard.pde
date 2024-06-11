import java.lang.Math;

class Scoreboard{
  int score;
  
  Scoreboard(){
    score = 0;
  }
  
  void display(){
    fill(255,255,224);
    rect(40, 20, 150, 100, 10, 10, 10, 10);
    fill(0);
    text("Score:", 60, 60);
    text(score, 60, 100);
  }
  
  void addScore(int type) {
    int[] scores = {1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66};
    score += scores[type];
  }
  
  void clear(){
    score = 0; 
  }
}
