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
  ArrayList<String> files = filesInFolder(".");
  int numFiles = files.size();
  //float cardWidth = width/numFiles;
  //float cardHeight = cardWidth/(2560.0/1440.0);
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
  mouse = new PVector(0,0);
  
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
  direction.setMag(center.dist(mouse)/30);
  direction.limit(50);
  position.add(direction);
  
  
  // figure out if the mouse has been
  // newly-pressed on this draw frame
  mouseDown = mousePressed && !pmouseDown;
  pmouseDown = mousePressed;
  
  // how many can we fit across a screen?
  //int cardwidth = 500;
  //int cardheight = 500;
  int nacross = floor(width  / cardwidth)  + 2; // plus 1 for safety
  int ndown   = floor(height / cardheight) + 2; // plus 1 for safety
  
  // starting with position as 00 and card also as 0
  
  //int nth = 0;
  
  int xacross = floor(position.x/cardwidth);
  int xdown   = floor(position.y/cardheight);
  
  int nth = xacross + xdown*nacross;
  
  for (int x = 0; x < nacross; x ++) {
    for (int y = 0; y < ndown; y ++) {
      
      //float s = 50/ sqrt(dist(Math.floorMod(int(x),width),  Math.floorMod(int(y),height),mouseX,mouseY));
      ellipse(
        -cardwidth  + Math.floorMod(floor(position.x),cardwidth)  + x*cardwidth, 
        -cardheight + Math.floorMod(floor(position.y),cardheight) + y*cardheight, 4, 4);

      float cardx = -cardwidth + Math.floorMod(floor(position.x),cardwidth) + x*cardwidth;
      float cardy = -cardheight + Math.floorMod(floor(position.y),cardheight)+y*cardheight;
      float s = 1/ sqrt(sqrt(dist(cardx,cardy,mouseX,mouseY)));
      
      nth = Math.floorMod(x - xacross - (y-xdown) * nacross,cards.size());
      
      cards.get(nth)
           .display(
             cardx, 
             cardy,
             s);
      nth++;
    }
  }
  
  //for (float x = position.x; x <= position.x + (cardwidth * (nacross+2)); x += cardwidth)
  //  for (float y = position.y ; y <= position.y + (cardheight * (ndown+2)); y += cardheight) {
      

  //    float s = 50/ sqrt(dist(Math.floorMod(int(x),width),  Math.floorMod(int(y),height),mouseX,mouseY));
  //    //ellipse(Math.floorMod(int(x), width), Math.floorMod(int(y),height),s,s);
  //    cards.get(nth % cards.size())
  //         .display(
  //           Math.floorMod(int(x), nacross*cardwidth) - cardwidth, 
  //           Math.floorMod(int(y),ndown*cardheight) - cardheight,
  //           .7);
  //    nth++;
  //  }

  for (SketchCard card : cards) {
    //card.display(1,1,1);
  }
}

// this will be intercepted by the proxy class
void switchToSketch(String uid){
  println("switching to", uid);
}