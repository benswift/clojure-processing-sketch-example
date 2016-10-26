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

    // pull name and uid from screenshot path
    String[] m = match(imagePath, "(u[0-9][0-9][0-9][0-9][0-9][0-9][0-9])-?(.*)\\.png");
    if(m!=null){
      this.uid = m[1];
      this.name = m[2].replace('-', ' '); // even if this is the empty string that's ok
    }
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

      s = 1;
      
      if(mouseDown) {
        switchToSketch(uid);
      }
    } else {
      h = max(0,h-10); // this will work when there is enough sketches to fill the screen
    }
    
    float dw = this.width()*s;
    float dh = this.height()*s;
    image(thumbnail, x-dw/2, y-dh/2,dw,dh);
    
    //stroke(255);
    fill(0,0,200,140);
    if (hover(x,y,s)) {
      filter(ADD);
      rect(x-dw/2, y-dh/2,dw,dh);
      
      fill(255);
      textSize(20);
      text(name, x - dw/2 + 24, y + dh/2 - 48);
      textSize(14);
      text(uid, x - dw/2 + 24, y + dh/2 - 24);
  }

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