boolean mouseDown;
boolean pmouseDown;
ArrayList<SketchCard> cards;
PVector position;
PVector direction;
PVector center;
PVector mouse;
PVector weight;

int cardwidth;
int cardheight;
int padding;

boolean opening = false;
String currentUID = "";
String currentDisplayname = "";
int loadtime = 0;

boolean autoMode = true;

// adapted from filesToArrayList() function by Docbones (GPL)
// https://forum.processing.org/one/topic/listing-files-in-a-folder.html
ArrayList<String> filesInFolder(String folderPath) {
  ArrayList<String> filesList = new ArrayList<String>();
  File file = new File(dataPath(folderPath));

  if (file != null) {
    File[] files = file.listFiles();

    for (File f : files) {
      filesList.add(f.getAbsolutePath());
    }
  }
  filesList.sort(null);
  return filesList;
}

void loadCards() {
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

  position = new PVector(0, 0);
  weight = new PVector(0, 0);
  direction = new PVector(0, 1);
  center = new PVector(width/2, height/2);
  mouse = new PVector(width/2, height/2);

  cardwidth = 240;
  cardheight = 140;
  padding = 24;
  loadCards();
}

void draw() {
  if (!opening) {
    background(0);

    if (!autoMode) {
      mouse.set(mouseX, mouseY);
    } else {
      switch(frameCount % 100) {
        case 0: 
          mouse.set(width/2,height/2); 
          if(frameCount % 2000 == 0) {
            SketchCard x =cards.get(int(random(0,cards.size())));
            switchToSketch(x.uid);
            opening = true;
            currentDisplayname = x.name;
            currentUID = x.uid;
          }
          break;
        case 50: mouse.set(random(0,width),random(0,height)); break;
      }

    }
    direction = center.copy();
    direction.sub(mouse);
    direction.setMag(center.dist(mouse)/(autoMode?270:30));
    if (direction.mag() < (autoMode?1:10)) direction.setMag(0);
    weight.add(direction);
    weight.limit(80);
    weight.mult((autoMode?.95:0.70));
    position.add(weight); 



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
          -cardwidth  + Math.floorMod(floor(position.x), cardwidth)  + x*cardwidth, 
          -cardheight + Math.floorMod(floor(position.y), cardheight) + y*cardheight, 4, 4);

        float cardx = -cardwidth + Math.floorMod(floor(position.x), cardwidth) + x*cardwidth;
        float cardy = -cardheight + Math.floorMod(floor(position.y), cardheight)+y*cardheight;
        float s = 24/ sqrt(518+ dist(cardx, cardy, mouseX, mouseY));

        int nth = Math.floorMod(x - xacross - (y-xdown) * nacross, cards.size());

        if (cards.get(nth).hover(cardx, cardy, s))
          anyHover = true;

        cards.get(nth)
          .display(
          cardx, 
          cardy, 
          s);
      }
    }

    if (!anyHover)
      cursor(ARROW);
  } else {
    loader();
    loadtime ++;
    if (loadtime > 50* 30) {
      loadtime = 0;
      opening = false;
    }
  }
}

// this will be intercepted by the proxy class
void switchToSketch(String uid) {
  println("switching to", uid);
}

void loader() {
  noStroke();
  fill(0, 0, 0, min(loadtime, 30));
  rect(0, 0, width, height);
  stroke(255, min(sq(loadtime/3), 255));
  noFill();

  float x = float(frameCount) /4;
  noFill();
  stroke(255, min(sq(loadtime/3), 255));

  arc(width/2, height/2, 380, 380, 0.0+x, 0.5+x);
  stroke(255, min(sq(loadtime/300), 255));
  ellipse(width/2, height/2, 380, 380);


  textAlign(CENTER);
  textSize(min(sqrt(float(loadtime)*6)+10, 300));
  blendMode(ADD);
  fill(255, 0, 0, min(sqrt(float(loadtime)*10), 255));
  text(currentDisplayname, width/2, height/2);
  fill(0, 0, 255, min(sqrt(float(loadtime)*10), 255));
  text(currentDisplayname, width/2, height/2);
  fill(0, 255, 0, min(sqrt(float(loadtime)*10), 255));
  text(currentDisplayname, width/2 +min(float(loadtime)/302, 6), height/2);

  textSize(min(sqrt(float(loadtime)*6)+10, 300)/2);
  fill(255, 0, 0, min(sqrt(float(loadtime)*10), 255));
  text(currentUID, width/2, height/2 + min(sqrt(float(loadtime)*6)+10, 300));
  fill(0, 0, 255, min(sqrt(float(loadtime)*10), 255));
  text(currentUID, width/2, height/2 + min(sqrt(float(loadtime)*6)+10, 300));
  fill(0, 255, 0, min(sqrt(float(loadtime)*10), 255));
  text(currentUID, width/2 +min(float(loadtime)/502, 6), height/2 + min(sqrt(float(loadtime)*6)+10, 300));
  blendMode(NORMAL);
}