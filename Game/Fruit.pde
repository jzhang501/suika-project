class Fruit{
  PVector location;
  PVector velocity;
  PVector acceleration;
  color c;
  float mass;
  
  Fruit(float x, float y, float xVel, float yVel){  
      location = new PVector(x, y);
      velocity = new PVector(xVel, yVel);
      acceleration = new PVector(0, 0);
      c = color(random(255), random(255), random(255));
      mass = random(0.2, 2);
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
    if (x <= 0 || x >= 1000) {
      velocity.set(velocity.array()[0] * -.5, velocity.array()[1] * .5);
    }
    if (y <= 0 || y >= 800) {
      velocity.set(velocity.array()[0] * .5 , velocity.array()[1] * -.5);
    }
  }
  
  void applyForce(PVector force) {
    PVector netAcc = force.div(mass);
    acceleration.add(netAcc);
  }
  
  void display(){
    stroke(1);
    fill(c);
    ellipse(location.x, location.y, 50 * mass, 50 * mass);
  }
}
