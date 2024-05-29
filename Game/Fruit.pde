import java.lang.Math;

class Fruit{
  PVector location;
  PVector velocity;
  PVector acceleration;
  color c;
  float mass;
  float radius;
  int type;
  
// 0 cherry, 1 strawberry, 2 grape, 3 dekopon, 4 orange, 5 apple, 6 pear, 7 peach, 8 pineapple, 9 melon, 10 watermelon
  color[] colors = new color[] {
    color(209, 35, 4),
    color(255, 71, 71),
    color(120, 48, 252),
    color(250, 172, 70),
    color(245, 105, 12),
    color(227, 16, 16),
    color(252, 246, 124),
    color(255, 173, 217),
    color(255, 245, 102),
    color(196, 255, 150),
    color(78, 204, 105)
  };

  Fruit(float x, float y, float xVel, float yVel, int t){  
      location = new PVector(x, y);
      velocity = new PVector(xVel, yVel);
      acceleration = new PVector(0, 0);
      type = t;
      c = colors[type];
      mass = type + 1;
      radius = (float) 10 * mass;
  }

  void move(){
   location.add(velocity);
   velocity.add(acceleration);
   acceleration = new PVector(0, 0);
   velocity.limit(10);
  }

  void bounce(){
    float x = location.x;
    float y = location.y;
    if (x < radius+160){
      velocity.set(velocity.x * -.3, velocity.y * .3);
      location.set(radius+160, y);
    } else if (x > 640-radius){
      velocity.set(velocity.x * -.3, velocity.y * .3);
      location.set(640-radius, y);
    }
    if (y > 950-radius){
      velocity.set(velocity.x * .3 , velocity.y * -.3);
      location.set(x, 950-radius);
    }
  }
  
  void collide(Fruit other){
    if (this.location.dist(other.location) < this.radius + other.radius) {
      PVector difference = this.location.copy().sub(other.location);
      while (this.location.dist(other.location) <= this.radius + other.radius) {
        PVector shift = difference.copy().normalize();
        this.location.add(shift);
        other.location.sub(shift);
      }
      PVector finalVel1 = new PVector(1,0);
      PVector finalVel2 = new PVector(1,0);
      float mag1 = (2 * this.mass) / (this.mass + other.mass) * this.velocity.mag() - (this.mass - other.mass) / (this.mass + other.mass) * other.velocity.mag();
      finalVel1.setMag(mag1*.3);
      float mag2 = (this.mass - other.mass) / (this.mass + other.mass) * this.velocity.mag() + (2 * other.mass) / (this.mass + other.mass) * other.velocity.mag();
      finalVel2.setMag(mag2*.3);
      float heading = this.location.copy().sub(other.location).heading();
      finalVel1.rotate(heading);
      finalVel2.rotate(heading+3.1415);
      this.velocity = finalVel1;
      other.velocity = finalVel2;
    }
  }
  
  void merge(Fruit other){
  }

  void applyForce(PVector force){
    PVector netAcc = force.div(mass);
    acceleration.add(netAcc);
  }

  void display(){
    stroke(1);
    fill(c);
    circle(location.x, location.y, radius*2);
    fill(0);
    circle(location.x + 3 * mass, location.y - .3 * mass, radius/3);
    circle(location.x - 3 * mass, location.y - .3 * mass, radius/3);
    arc(location.x, location.y + 3 * mass, radius/3, radius/3, 0, PI+QUARTER_PI, OPEN);
  }

}
