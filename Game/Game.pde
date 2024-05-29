ArrayList<Fruit> fruitList;


void setup() {
  size(800,1000);
  fruitList = new ArrayList<Fruit>();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    float x = mouseX;
    float y = mouseY;
    float xVel = 0;
    float yVel = 0;
    fruitList.add(new Fruit(x, y, xVel, yVel));
  }
}

void draw() {
  // You may change the background
  background(173, 216, 230);
  for (Fruit f: fruitList) {
    PVector gravity = new PVector(0, f.mass*.1);
    f.applyForce(gravity);
    f.move();
    f.bounce();
    for (Fruit g: fruitList) {
      if (!f.equals(g)) {
        f.collide(g);
      }
    }
    f.display();
  }
  fill(0);
}
