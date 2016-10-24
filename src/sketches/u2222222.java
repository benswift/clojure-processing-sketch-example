import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class u2222222 extends PApplet {

public void setup() {
  
  noStroke();
}

public void draw() {
  fill(random(255), 50);
  float d = random(200);
  ellipse(random(width), random(height), d, d);
}

public void keyPressed(){
  if(key == 'S'){
    println("taking screenshot...");
    save("screenshot.png");
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "u2222222" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
