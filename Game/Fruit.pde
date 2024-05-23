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
      velocity.set(velocity.array()[0] * -.25, velocity.array()[1] * .25);
    }
    if (y <= radius || y >= 800 - radius) {
      velocity.set(velocity.array()[0] * .25 , velocity.array()[1] * -.25);
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
