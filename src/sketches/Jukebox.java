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

public class Jukebox extends PApplet {

boolean mouseDown;
boolean pmouseDown;
ArrayList<SketchCard> cards;

// adapted from filesToArrayList() function by Docbones (GPL)
// https://forum.processing.org/one/topic/listing-files-in-a-folder.html
public ArrayList<String> filesInFolder(String folderPath) {
  ArrayList<String> filesList = new ArrayList<String>();
  File file = new File(dataPath(folderPath));
  if(file != null){
    File[] files = file.listFiles();
    for (File f: files) {
      filesList.add(f.getAbsolutePath());
    }
  }
  filesList.sort(null);
  return filesList;
}

public void loadCards(){
  cards = new ArrayList<SketchCard>(100);
  ArrayList<String> files = filesInFolder("/Users/ben/Code/clojure/exported-sketch-example/processing/Jukebox/data");
  for (String filename : files) {
    cards.add(new SketchCard(filename,
                             width/(files.size()),
                             width/(int)(files.size()*1.6f)));
  }
}

public void setup() {
  
  loadCards();
}

public void draw() {
  background(255);
  // figure out if the mouse has been
  // newly-pressed on this draw frame
  mouseDown = mousePressed && !pmouseDown;
  pmouseDown = mousePressed;

  for (int i = 0; i < cards.size(); i++) {
    SketchCard card = cards.get(i);
    card.display(i*card.width(), (height-card.height())/2.0f);
  }
}

// this will be intercepted by the proxy class
public void switchToSketch(String uid){
  println("switching to", uid);
}
class SketchCard {
  PImage thumbnail;
  String name;

  SketchCard(String imagePath, int w, int h) {
    thumbnail = loadImage(imagePath);
    thumbnail.resize(w, h);
    name = imagePath;
  }

  public void resize(int w, int h){
    thumbnail.resize(w, h);
  }
  
  public void display(float x, float y){
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

  public float width(){
    return thumbnail.width;
  }

  public float height(){
    return thumbnail.height;
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "Jukebox" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
