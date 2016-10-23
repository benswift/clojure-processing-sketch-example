import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class MinimPlayPause extends PApplet {



Minim minim;
AudioPlayer player;

public void setup() {
  

  // create the minim object (necessary to use the library)
  minim = new Minim(this);
  
  player = minim.loadFile("/Users/ben/Code/clojure/exported-sketch-example/processing/MinimPlayPause/data/gong.mp3");
  player.loop();
}

public void draw() {
  if(player.isPlaying())
    background(random(100));
}

public void keyPressed(){
  if(player.isPlaying())
    player.pause();
  else
    player.loop();
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "MinimPlayPause" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
