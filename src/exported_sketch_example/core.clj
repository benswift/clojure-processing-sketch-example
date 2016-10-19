(ns exported-sketch-example.core
  (:require [exported-sketch-example.sketches :as sk])
  (:gen-class))

(defn -main [& args]
  (sk/run-example-sketch)
  (Thread/sleep 5000)
  (sk/run-random-circles)
  (Thread/sleep 5000)
  (sk/run-example-sketch)
  (Thread/sleep 5000)
  (sk/run-random-circles)
  (Thread/sleep 5000)
  (println "done, bye!")
  (System/exit 0))
