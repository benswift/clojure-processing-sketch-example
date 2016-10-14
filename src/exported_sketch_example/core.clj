(ns exported-sketch-example.core
  (:import processing.core.PApplet ExampleSketch)
  (:require [quil.core :as q]
            [quil.middleware :as m]))

(defn create-and-run []
  (let [sketch (ExampleSketch.)]
    (PApplet/runSketch 
      (into-array String [])
      sketch)))

;; currently crashes :(
(create-and-run)
