PImage img;

void setup() {
  fullScreen();
  img = loadImage("testImage.png");
}

void draw() {
  image(img, 0, 0, width, height);
  noLoop();
}


