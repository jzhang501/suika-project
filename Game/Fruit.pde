import java.lang.Math;

class Fruit{
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
  float rotation; // in radians
  
  PShape[] fruitImages = new PShape[] {loadShape("cherry.svg"), loadShape("strawberry.svg"), 
    loadShape("grapes.svg"), loadShape("dekopon.svg"), loadShape("persimmon.svg"), 
    loadShape("apple.svg"), loadShape("pear.svg"), loadShape("peach.svg"), 
    loadShape("pineapple.svg"), loadShape("melon.svg"), loadShape("watermelon.svg")};

  Fruit(float x, float y){  
      location = new PVector(x, y);
      velocity = new PVector(0, 0);
      acceleration = new PVector(0, 0);
      type = (int) (Math.random()*11);
      mass = type+1;
      radius = (float) 10 * mass;
  }

  Fruit(float x, float y, int typeI){  
      location = new PVector(x, y);
      velocity = new PVector(0, 0);
      acceleration = new PVector(0, 0);
      type = typeI;
      mass = type+1;
      radius = (float) 10 * mass;
  }

  void move(){
   location.add(velocity);
   velocity.add(acceleration);
   acceleration = new PVector(0, 0);
   //velocity.limit(10);
   rotation += velocity.x/radius;
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
    translate(location.x, location.y);
    rotate(rotation);
    shape(fruitImages[type], -1.3*radius, -1.3*radius, radius * 2.6, radius * 2.6);
    // eyes
    float eyeOffsetX = radius * 0.5;  
    float eyeOffsetY = radius * 0.2;
    if (eyesOpen) {
      fill(0);
      circle(- eyeOffsetX, - eyeOffsetY, radius / 2);      
      fill(0);
      circle(eyeOffsetX, - eyeOffsetY, radius / 2);
    } else {
      line(eyeOffsetX + radius/4, - eyeOffsetY, radius/4, - eyeOffsetY);
      line(- eyeOffsetX - radius/4, - eyeOffsetY, - radius/4, - eyeOffsetY);
    }
  }

  void mouth(){
    fill(0);
    arc(0, 3 * mass, radius/3, radius/3, 0, PI, CLOSE);
  }

  void display(){
    stroke(1);
    fill(c);
    blinking();
    mouth();
    rotate(-rotation);
    translate(-location.x, -location.y);
    //circle(location.x, location.y, radius*2);
    //fill(0);
    //circle(location.x + 3 * mass, location.y - .3 * mass, radius/3);
    //circle(location.x - 3 * mass, location.y - .3 * mass, radius/3);
    
  }

}
