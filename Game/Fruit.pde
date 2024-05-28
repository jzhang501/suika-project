import java.lang.Math;

class Fruit{
  float[] sizes = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
  PVector location;
  PVector velocity;
  PVector acceleration;
  color c;
  float mass;
  float radius;
  
  Fruit(float x, float y, float xVel, float yVel){  
      location = new PVector(x, y);
      velocity = new PVector(xVel, yVel);
      acceleration = new PVector(0, 0);
      c = color(random(255), random(255), random(255));
      // mass = random(0.2, 2);
      mass = (float) ((int) random(sizes));
      radius = (float) (40 * Math.sqrt(mass));
  }

  void move(){
   location.add(velocity);
   velocity.add(acceleration);
   acceleration = new PVector(0, 0);
   
   velocity.limit(10);
  }

  void bounce(){
    float x = location.array()[0];
    float y = location.array()[1];
    if (x <= radius) {
      velocity.set(velocity.array()[0] * -.3, velocity.array()[1] * .3);
      location.set(radius, y);
    } else if (x >= 1000 - radius) {
      velocity.set(velocity.array()[0] * -.3, velocity.array()[1] * .3);
      location.set(1000-radius, y);
    }
    if (y >= 800 - radius) {
      velocity.set(velocity.array()[0] * .3 , velocity.array()[1] * -.3);
      location.set(x, 800-radius);
    }
  }
  
  void collide(Fruit other) {
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
  
  void applyForce(PVector force) {
    PVector netAcc = force.div(mass);
    acceleration.add(netAcc);
  }
  
  void blinking() {
    circle(location.x, location.y, radius*2);
    circle(location.x + 15 * mass, location.y - 4 * mass, radius/2);
    circle(location.x - 15 * mass, location.y - 4 * mass, radius/2);
  }
  void display(){
    stroke(1);
    fill(c);
    blinking();
  }
}
