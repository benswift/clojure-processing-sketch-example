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
  for (String filename : files) {
    cards.add(new SketchCard(filename,
                             width/(files.size()),
                             width/(int)(files.size()*1.6)));
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

  for (int i = 0; i < cards.size(); i++) {
    SketchCard card = cards.get(i);
    card.display(i*card.width(), (height-card.height())/2.0);
  }
}

// this will be intercepted by the proxy class
void switchToSketch(String uid){
  println("switching to", uid);
}
