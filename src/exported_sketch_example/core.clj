(ns exported-sketch-example.core
  (:require [exported-sketch-example.sketches :as sk])
  (:gen-class))

(defn -main [& args]
  (let [sleep-dur 5000]
    (sk/run-example-sketch)
    (Thread/sleep sleep-dur)
    (sk/run-random-circles)
    (Thread/sleep sleep-dur)
    (sk/run-example-sketch)
    (Thread/sleep sleep-dur)
    (sk/run-random-circles)
    (Thread/sleep sleep-dur))
  (println "done, bye!")
  (System/exit 0))
