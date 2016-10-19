# exported-sketch-example

An example of running exported Processing sketches from Clojure.

**This is a work-in-progress**

## Usage

Currently, getting the sketches into Clojure involves a bit of manual
fiddling (although hopefully this will be fully automated in the
future). The process is:

1. from Processing (either in the IDE or using the `processing-java`
   command-line tool) export the sketch
   
2. find the `<SketchName>.java` in the exported application bundle,
   and copy it into `src/sketches`

3. import the sketch into the `exported-sketch-example.sketches`
   namespace in `src/exported_sketch_example/sketches.clj`

4. profit?

## TODO

1. automate the generation of the java classes from the Processing
   sketch folders---not sure exactly how to do this, but
   `processing.mode.java.JavaBuild/preprocess()` looks promising...

2. test to see if it works with sketches which have stuff in their
   `data/` folder---where does that get exported to?
   
3. add a more sophisticated event loop than the sleepy `-main`
   function
   
## License

Copyright © 2016 Ben Swift

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version.
