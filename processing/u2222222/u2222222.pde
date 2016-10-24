void setup() {
  fullScreen();
  noStroke();
}

void draw() {
  fill(random(255), 50);
  float d = random(200);
  ellipse(random(width), random(height), d, d);
}

void keyPressed(){
  if(key == 'S'){
    println("taking screenshot...");
    save("screenshot.png");
  }
}
