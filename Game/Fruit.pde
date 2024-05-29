import java.lang.Math;

class Fruit{
  float[] sizes = {0.3, 0.5, 0.7, 1, 1.5};
  int timeBetweenBlink = 1000;
  int blinkTime = 0;
  boolean eyesOpen = true;
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

  Fruit(float x, float y){  
      location = new PVector(x, y);
      velocity = new PVector(0, 0);
      acceleration = new PVector(0, 0);
      type = (int) (Math.random()*11);
      c = colors[type];
      mass = type;
      radius = (float) 10 * mass;
  }

  Fruit(float x, float y, int typeI){  
      location = new PVector(x, y);
      velocity = new PVector(0, 0);
      acceleration = new PVector(0, 0);
      type = typeI;
      c = colors[type];
      mass = type;
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
  
  void collide(Fruit other) {
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
  
  void merge(Fruit other) {
    float newX = (this.location.x + other.location.x) / 2;
    float newY = (this.location.y + other.location.y) / 2;
    PVector newLoc = new PVector(newX, newY);
    if (this.type < 10) {
      fruitList.add(new Fruit(newLoc.array()[0], newLoc.array()[1], this.type+1));
    }
    fruitList.remove(this);
    fruitList.remove(other);
  }
  
  void applyForce(PVector force) {
    PVector netAcc = force.div(mass);
    acceleration.add(netAcc);
  }
  
  void blinking() {
    int time = millis();
    if (time - blinkTime >= timeBetweenBlink) {
      eyesOpen = !eyesOpen;
      blinkTime = time;
    }
    // big fruit
    circle(location.x, location.y, radius * 2);
    float eyeOffsetX = radius * 0.5;  
    float eyeOffsetY = radius * 0.2;
    // eyes
    if (eyesOpen) {
      fill(0);
      circle(location.x - eyeOffsetX, location.y - eyeOffsetY, radius / 2);
      fill(0);
      circle(location.x + eyeOffsetX, location.y - eyeOffsetY, radius / 2);
    } else {
        line(location.x + eyeOffsetX + radius/4, location.y - eyeOffsetY, location.x + radius/4, location.y - eyeOffsetY);
        line(location.x - eyeOffsetX - radius/4, location.y - eyeOffsetY, location.x - radius/4, location.y - eyeOffsetY);
    }
    // mouth 
    float mouthOffsetX = radius * 0.5;
    float mouthOffsetY = radius * 0.5;
    //line(location.x + mouthOffsetX , location.y + mouthOffsetY, location.x - mouthOffsetX, location.y + mouthOffsetY);
    arc(location.x, location.y + 3 * mass, radius/3, radius/3, 0, PI+QUARTER_PI, OPEN);
}

  void display(){
    stroke(1);
    fill(c);
    blinking();
    //circle(location.x, location.y, radius*2);
    //fill(0);
    //circle(location.x + 3 * mass, location.y - .3 * mass, radius/3);
    //circle(location.x - 3 * mass, location.y - .3 * mass, radius/3);
    
  }

}
