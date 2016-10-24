(ns exported-sketch-example.core
  (:import ExampleSketch RandomCircles)
  (:require [exported-sketch-example.sketches :as sk])
  (:gen-class))

(def sketches [ExampleSketch RandomCircles])
(defmacro rand-sketch []
  (rand-nth sketches))

(defn -main [& args]
  (let [sleep-dur 5000]
    ; specific sketches can be run as an argument run-sketch 
    ; ((double parentheses due to macro))
    ((sk/run-sketch ExampleSketch))
    (Thread/sleep sleep-dur)
    ((sk/run-sketch RandomCircles))
    ; but we'll probably want to use a vector to store them
    (Thread/sleep sleep-dur))
  (println "done, bye!")
  (System/exit 0))
