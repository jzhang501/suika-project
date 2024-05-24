import java.util.Arrays;

class Fruit{
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
      mass = random(0.2, 2);
      radius = 25 * mass;
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
    if (x <= radius || x >= 1000 - radius) {
      velocity.set(velocity.array()[0] * -.3, velocity.array()[1] * .3);
    }
    if (y >= 800 - radius) {
      velocity.set(velocity.array()[0] * .3 , velocity.array()[1] * -.3);
      location.set(x, 800-radius);
    }
  }
  
  void collide(Fruit other) {
    if (this.location.dist(other.location) < this.radius + other.radius) {
      PVector finalVel1 = new PVector(1,0);
      PVector finalVel2 = new PVector(1,0);
      float mag1 = 2 * this.mass / (this.mass + other.mass) * this.velocity.mag() - (this.mass - other.mass) / (this.mass + other.mass) * other.velocity.mag();
      finalVel1.setMag(mag1);
      float mag2 = (this.mass - other.mass) / (this.mass + other.mass) * this.velocity.mag() + (2 * other.mass) / (this.mass + other.mass) * other.velocity.mag();
      finalVel2.setMag(mag2);
      float heading = this.location.sub(other.location).heading();
      System.out.println(heading / 3.14 * 180);
      finalVel1.rotate(heading);
      finalVel2.rotate(heading);
      
      this.velocity = finalVel1;
      System.out.println(Arrays.toString(this.velocity.array()));
      other.velocity = finalVel2;
      System.out.println(Arrays.toString(other.velocity.array()));
    }
  }
  
  void applyForce(PVector force) {
    PVector netAcc = force.div(mass);
    acceleration.add(netAcc);
  }
  
  void display(){
    stroke(1);
    fill(c);
    circle(location.x, location.y, radius*2);
  }
}
