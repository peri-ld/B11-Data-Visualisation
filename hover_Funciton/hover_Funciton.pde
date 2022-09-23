  int x1Bound = 1000/2-100;
  int x2Bound = 1000/2+100;
  int y1Bound = 800/2-100;
  int y2Bound = 800/2+100;
  int day;

void setup() {
  size(1000, 800);
}

void draw() {
  background(100, 300, 45);
  fill(0);
  translate(width/2-100, height/2-100);
  square(0, 0, 200);
  
  if (mouseX > x1Bound && mouseX < x2Bound && mouseY > y1Bound && mouseY < y2Bound) {
    translate(-50, -50);
    for(int i = 200; i <= 300; i++) {
      square(0, 0, i);
    }
    day = 1;
  }
}
