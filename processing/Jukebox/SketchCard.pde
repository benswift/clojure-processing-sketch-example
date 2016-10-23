class SketchCard {
  PImage thumbnail;
  String name;

  SketchCard(String imagePath, int w, int h) {
    thumbnail = loadImage(imagePath);
    thumbnail.resize(w, h);
    name = imagePath;
  }

  void resize(int w, int h){
    thumbnail.resize(w, h);
  }
  
  void display(float x, float y){
    image(thumbnail, x, y);
    // should possibly do edge triggering
    if(mouseDown &&
       x < mouseX &&
       y < mouseY &&
       mouseX < x+thumbnail.width &&
       mouseY < y+thumbnail.height){
      switchToSketch(name);
    }
  }

  float width(){
    return thumbnail.width;
  }

  float height(){
    return thumbnail.height;
  }
}
