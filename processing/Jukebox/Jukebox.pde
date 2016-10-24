boolean mouseDown;
boolean pmouseDown;
ArrayList<SketchCard> cards;

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
  float cardWidth = width/numFiles;
  float cardHeight = cardWidth/(2560.0/1440.0);
  for (int i = 0; i < numFiles; i++) {
        cards.add(new SketchCard(files.get(i),
                                 i*cardWidth,
                                 (height-cardHeight)/2.0,
                                 (int)cardWidth,
                                 (int)cardHeight));
  }
}

void setup() {
  fullScreen();
  loadCards();
}

void draw() {
  background(255);
  // figure out if the mouse has been
  // newly-pressed on this draw frame
  mouseDown = mousePressed && !pmouseDown;
  pmouseDown = mousePressed;

  for (SketchCard card : cards) {
    card.display();
  }
}

// this will be intercepted by the proxy class
void switchToSketch(String uid){
  println("switching to", uid);
}
