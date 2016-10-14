(ns exported-sketch-example.core
  (:import processing.core.PApplet ExampleSketch)
  (:require [quil.core :as q]))

(defn create-and-run []
  (let [sketch (ExampleSketch.)]
    (PApplet/runSketch 
      (into-array String ["Example Sketch"])
      sketch)))

(create-and-run)
