class SketchCard {
  PImage thumbnail;
  String name;
  String uid;
  float x, y;
  float h = 0;

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

    
    if (hover(x,y,s)) {
      cursor(HAND);
      noFill();
      strokeWeight(2);
      stroke(255,h);
      h = min(255, h + 10);

      s = .8;
      
      if(mouseDown) {
        switchToSketch(name);
      }
    } else {
      h = max(0,h-10); // this will work when there is enough sketches to fill the screen
    }
    
    float dw = this.width()*s;
    float dh = this.height()*s;
    image(thumbnail, x-dw/2, y-dh/2,dw,dh);
    if (hover(x,y,s))
      rect(x-dw/2, y-dh/2,dw,dh);

  }
  
  boolean hover(float x, float y, float s) {
    float dw = this.width()*s;
    float dh = this.height()*s;
    return mouseX >= x-dw/2 && mouseX < x-dw/2 + dw && mouseY >= y-dh/2 && mouseY < y-dh/2 + dh;
  }

  float width(){
    return thumbnail.width;
  }

  float height(){
    return thumbnail.height;
  }
}
