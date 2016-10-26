(ns clojure-processing-sketch-example.core
  (:require [clojure-processing-sketch-example.sketches :as sk])
  (:gen-class))

(defn -main [& args]
  ;; TODO just check if this'll work with no images
  (sk/init)
  (sk/gallery-loop 5)
  (System/exit 0))
