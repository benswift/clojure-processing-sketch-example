# clojure-processing-sketch-example

An example of running exported Processing sketches from Clojure.

**This is a work-in-progress**

## Usage

```
lein run
```

## Adding new sketches

Currently, getting the sketches into Clojure involves a bit of manual
fiddling (although hopefully this will be fully automated in the
future). The process is:

1. from Processing (either in the IDE or using the `processing-java`
   command-line tool) export the sketch
   
2. find the `<SketchName>.java` in the exported application bundle,
   and copy it into `src/sketches`

3. import the sketch into the `clojure-processing-sketch-example.sketches`
   namespace in `src/clojure_processing_sketch_example/sketches.clj`

4. profit?

## Alternative approaches

There are a few ways this could be better, but I haven't got them
working :(

- load the exported sketch classes (and their dependencies) from the
  jar file(s) created by the `processing-java --export` process, i.e.
  don't require manually moving the `SketchName.java` file into the
  `src/sketches` folder

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
