import java.lang.Math;

class Stopwatch {
  int ticks;

  Stopwatch() {
    ticks = 0;
  }

  void display() {
    fill(255, 255, 224);
    rect(610, 20, 150, 100, 10, 10, 10, 10);
    fill(0);
    text("Time:", 630, 60);
    
    int minutes = ticks / 900;
    int sec = (ticks / 30) % 60;
    String timeString = nf(minutes, 2) + ":" + nf(sec, 2);
    text(timeString, 630, 100);
  }

  void addSecond() {
    ticks++;
  }

  void clear() {
    ticks = 0;
  }
}
