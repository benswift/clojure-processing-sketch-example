import ddf.minim.*;

Minim minim;
AudioPlayer player;

void setup() {
  fullScreen();

  // create the minim object (necessary to use the library)
  minim = new Minim(this);
  
  player = minim.loadFile("gong.mp3");
  player.loop();
}

void draw() {
  if(player.isPlaying())
    background(random(100));
}

void keyPressed(){
  if(player.isPlaying())
    player.pause();
  else
    player.loop();

  if(key == 'S'){
    println("taking screenshot...");
    save("screenshot.png");
  }
}
