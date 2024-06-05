import java.lang.Math;

class Scoreboard{
  int score;
  
  Scoreboard(){
    score = 0;
  }
  
  void calculate(){
    
  }
  
  void display(){
    text(score, 20, 40);
  }
  
  void addScore(int type) {
    int[] scores = {1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66};
    score += scores[type];
  }
}
