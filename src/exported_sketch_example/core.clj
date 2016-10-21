(ns exported-sketch-example.core
  (:require [exported-sketch-example.sketches :as sk])
  (:gen-class))

(defn -main [& args]
  (let [sleep-dur 5000]
    ((:runner (first sk/sketches)))
    (Thread/sleep sleep-dur)
    ((:runner (second sk/sketches)))
    (Thread/sleep sleep-dur))
  (println "done, bye!")
  (System/exit 0))

