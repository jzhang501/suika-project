ArrayList<Fruit> fruitList;

void setup() {
  size(1000, 800);
  fruitList = new ArrayList<Fruit>();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    float x = mouseX;
    float y = mouseY;
    fruitList.add(new Fruit(x, y));
  }
}

void draw() {
  // You may change the background
  background(173, 216, 230);
  for (int i = 0; i < fruitList.size(); i++) {
    Fruit f = fruitList.get(i);
    PVector gravity = new PVector(0, f.mass*.1);
    f.applyForce(gravity);
    f.move();
    f.bounce();
    for (int j = 0; j < fruitList.size(); j++) {
      Fruit g = fruitList.get(j);
      if (!f.equals(g)) {
        if (f.location.dist(g.location) < f.radius + g.radius) {
          if (f.type==g.type) {
            f.merge(g);
            break;
          } else {
            f.collide(g);
          }
        }
      }
    }
    f.display();
  }
  fill(0);
}
