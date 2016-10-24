# clojure-processing-sketch-example

An example of running exported Processing sketches from Clojure.

**This is a work-in-progress**

## Usage

### Quick version

If you're on OSX (and maybe Linux - untested) with a modern Emacs,
`processing-java` on your path, and an Internet connection, this
should get you up and running:

(I know the Emacs thing is a pain, but I'm sticking with the tools I
know for the moment)

**Step 1** (Terminal)

```
git clone https://github.com/benswift/clojure-processing-sketch-example
```

**Step 2** (in Emacs)

```
M-x load-file RET utils/exporter.el RET
```

**Step 3** (in Terminal)

```
lein run
```

### Long version

Currently, getting the sketches into Clojure involves either a bit of manual
fiddling or using the elisp helper functions in utils/exporter.el

The process is:

1. from Processing (either in the IDE or using the `processing-java`
   command-line tool) export the sketches in the processing directory

2. locate the jar files inside the
   application.macosx/<SketchName>.app/Contents/Java/ directory for
   each sketch

3. using `lein localrepo` (or possibly the `mvn` CLI) install these
   jar files using comp1720 as the artifact-id and 0.0.0-SNAPSHOT as
   the version

4. ensure that these dependencies are referenced in the :dependencies
   vector in project.clj

4. lein run

## TODO

1. fix problem with sketches not being able to find their data folder
   `data/` folder---where does that get exported to?

2. add a more sophisticated event loop

## License

Copyright © 2016 Ben Swift

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version.
