void setup() {
  size(800, 600);
  noStroke();
  fill(180);
}

void draw() {
  background(0);
  ellipse(width/2, height/2, width*sin(frameCount*0.03), height*sin(frameCount*0.043));
}
