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
    float xVel = 0;
    float yVel = 0;
    int type = (int) (Math.random()*5);
    fruitList.add(new Fruit(x, y, xVel, yVel, type));
  }
}

void draw() {
  background(196,164,132);
  fill(255,255,224);
  // The x of box is bounmded 150 to 650 on outer and 160 to 640 on inner
  // The y on top is 150 and ends at 950 inner or 960 outer at the bottom
  rect(150,150,10,800);
  rect(640,150,10,800);
  rect(150,950,500,10);
  for (int i = 0; i < fruitList.size(); i++){
    PVector gravity = new PVector(0,fruitList.get(i).mass*.1);
    fruitList.get(i).applyForce(gravity);
    fruitList.get(i).move();
    fruitList.get(i).bounce();
    for (int j = 0; j < fruitList.size(); j++){
            if (!fruitList.get(i).equals(fruitList.get(j))) {
              fruitList.get(i).collide(fruitList.get(j));
        }
    }
    fruitList.get(i).display();
  }

  fill(0);
}
