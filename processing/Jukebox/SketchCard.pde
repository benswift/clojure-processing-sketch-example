class SketchCard {
  PImage thumbnail;
  String name;
  float x, y;
  float h = 0;

  SketchCard(String imagePath, float x, float y, int w, int h) {
    thumbnail = loadImage(imagePath);
    thumbnail.resize(w, h);
    name = imagePath;
    this.x = x;
    this.y = y;
  }

  void resize(int w, int h){
    thumbnail.resize(w, h);
  }

  boolean mouseOverCard(){
    return mouseDown && x < mouseX && y < mouseY && mouseX < x+thumbnail.width && mouseY < y+thumbnail.height;
  }
    
  void display(float x, float y, float s){
    boolean over = mouseOverCard();

    
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