import java.lang.Math;

class Stopwatch {
  int seconds;

  Stopwatch() {
    seconds = 0;
  }

  void display() {
    fill(255, 255, 224);
    rect(610, 20, 150, 100, 10, 10, 10, 10);
    fill(0);
    text("Time:", 630, 60);
    
    int minutes = seconds / 60;
    int sec = seconds % 60;
    String timeString = nf(minutes, 2) + ":" + nf(sec, 2);
    text(timeString, 630, 100);
  }

  void addSecond() {
    seconds++;
  }

  void clear() {
    seconds = 0;
  }
}
