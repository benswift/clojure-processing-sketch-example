void setup() {
  fullScreen();
  noStroke();
  fill(180);
}

void draw() {
  background(0);
  ellipse(width/2, height/2, width*sin(frameCount*0.03), height*sin(frameCount*0.043));
}

void keyPressed(){
  if(key == 'S'){
    println("taking screenshot...");
    save("screenshot.png");
  }
}
