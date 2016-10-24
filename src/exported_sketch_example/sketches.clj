(ns exported-sketch-example.sketches
  (:use clojure.walk)
  (:import processing.core.PApplet
           ;; specific sketches
           ExampleSketch RandomCircles))

;; obviously, having a separate method for each sketch class doesn't
;; really scale. Macros to the rescue?

(defmacro run-sketch
  [sketch]
  `(fn [] 
     (PApplet/runSketch 
       (into-array String ["mysketch" "--present"])
       (proxy [~sketch] []
         (exitActual []
           (proxy-super destroy))))))

