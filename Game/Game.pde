ArrayList<Fruit> fruitList;

void setup() {
  size(800,1000);
  background(196,164,132);
  fruitList = new ArrayList<Fruit>();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    float x = mouseX;
    float y = 150;
    int type = (int) (Math.random()*5);
    fruitList.add(new Fruit(x, y, type));
  }
}

void draw() {
  background(196,164,132);
  fill(255,255,224);
  // The x of box is bounded 150 to 650 on outer and 160 to 640 on inner
  // The y on top is 150 and ends at 950 inner or 960 outer at the bottom
  rect(150,150,10,800);
  rect(640,150,10,800);
  rect(150,950,500,10);
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
      f.display();
    }
  }
}
