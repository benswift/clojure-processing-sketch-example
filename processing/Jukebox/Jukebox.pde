boolean mouseDown;
boolean pmouseDown;
ArrayList<SketchCard> cards;
PVector position;
PVector direction;
PVector center;
PVector mouse;

int cardwidth;
int cardheight;
int padding;

// adapted from filesToArrayList() function by Docbones (GPL)
// https://forum.processing.org/one/topic/listing-files-in-a-folder.html
ArrayList<String> filesInFolder(String folderPath) {
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

void loadCards(){
  cards = new ArrayList<SketchCard>(100);
  ArrayList<String> files = filesInFolder("/usr/local/share/comp1720");
  int numFiles = files.size();

  for (int i = 0; i < numFiles; i++) {
        cards.add(new SketchCard(files.get(i),
                                 i*cardwidth,
                                 (height-cardheight)/2.0,
                                 (int)cardwidth,
                                 (int)cardheight));
  }
}

void setup() {
  fullScreen();

  position = new PVector(0,0);
  direction = new PVector(0,1);
  center = new PVector(width/2,height/2);
  mouse = new PVector(width/2,height/2);

  cardwidth = 240;
  cardheight = 140;
  padding = 24;
  loadCards();
}

void draw() {
  background(0);

  mouse.set(mouseX,mouseY);
  direction = center.copy();
  direction.sub(mouse);
  if(direction.mag() < 100) direction.limit(0);
  direction.setMag(center.dist(mouse)/30);
  direction.limit(40);
  position.add(direction);

  boolean anyHover = false;


  // figure out if the mouse has been
  // newly-pressed on this draw frame
  mouseDown = mousePressed && !pmouseDown;
  pmouseDown = mousePressed;

  // how many can we fit across a screen?
  int nacross = floor(width  / cardwidth)  + 2; // plus 1 for safety
  int ndown   = floor(height / cardheight) + 2; // plus 1 for safety

  int xacross = floor(position.x/cardwidth);
  int xdown   = floor(position.y/cardheight);

  for (int x = 0; x < nacross; x ++) {
    for (int y = 0; y < ndown; y ++) {

      //float s = 50/ sqrt(dist(Math.floorMod(int(x),width),  Math.floorMod(int(y),height),mouseX,mouseY));
      ellipse(
        -cardwidth  + Math.floorMod(floor(position.x),cardwidth)  + x*cardwidth,
        -cardheight + Math.floorMod(floor(position.y),cardheight) + y*cardheight, 4, 4);
      
      float cardx = -cardwidth + Math.floorMod(floor(position.x),cardwidth) + x*cardwidth;
      float cardy = -cardheight + Math.floorMod(floor(position.y),cardheight)+y*cardheight;
      float s = 24/ sqrt(518+ dist(cardx,cardy,mouseX,mouseY));
      
      int nth = Math.floorMod(x - xacross - (y-xdown) * nacross,cards.size());
      
      if(cards.get(nth).hover(cardx,cardy,s))
        anyHover = true;
      
      cards.get(nth)
           .display(
             cardx, 
             cardy,
             s); 
    }
  }

  
  if(!anyHover)
    cursor(ARROW);
}

// this will be intercepted by the proxy class
void switchToSketch(String uid){
  println("switching to", uid);
}