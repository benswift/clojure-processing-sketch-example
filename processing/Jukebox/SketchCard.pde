class SketchCard {
  PImage thumbnail;
  String name;
  String uid;
  float x, y;

  SketchCard(String imagePath, float x, float y, int w, int h) {
    thumbnail = loadImage(imagePath);
    thumbnail.resize(w, h);
    this.x = x;
    this.y = y;

    // string munging
    this.name = imagePath;
    String[] m = match(imagePath, "(u[0-9][0-9][0-9][0-9][0-9][0-9][0-9]).png");
    if(m!=null)
      this.uid = m[1];
    else{
      this.uid = "uXXXXXXX";
      println("no uid found in ", imagePath);
    }
  }

  void resize(int w, int h){
    thumbnail.resize(w, h);
  }

  void display(float x, float y, float s){
    float dw = this.width()*s;
    float dh = this.height()*s;
    image(thumbnail, x-dw/2, y-dh/2,dw,dh);
    if(mouseDown && dist(mouseX, mouseY, x, y) < 50){
      switchToSketch(uid);
      println(uid);
    }
  }

  float width(){
    return thumbnail.width;
  }

  float height(){
    return thumbnail.height;
  }
}
