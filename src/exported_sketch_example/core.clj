(ns exported-sketch-example.core
  (:require [quil.core :as q]
            [exported-sketch-example.sketches :as sk])
  (:gen-class))

(def sketches (sk/create-all))

(defn -main [& args]
  (sk/run (first (shuffle sketches))))
