(ns exported-sketch-example.sketches
  (:import processing.core.PApplet
           ;; specific sketches
           ExampleSketch RandomCircles))

;; obviously, having a separate method for each sketch class doesn't
;; really scale. Macros to the rescue?

(defn run-example-sketch []
  (PApplet/runSketch
      (into-array String ["mysketch" "--present"])
      (proxy [ExampleSketch] []
        (exitActual []
          (println "seeya mate!")
          (proxy-super destroy)))))

(defn run-random-circles []
  (PApplet/runSketch
      (into-array String ["mysketch" "--present"])
      (proxy [RandomCircles] []
        (exitActual []
          (println "seeya mate!")
          (proxy-super destroy)))))
