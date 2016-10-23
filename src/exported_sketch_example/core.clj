(ns exported-sketch-example.core
  (:require [exported-sketch-example.sketches :as sk])
  (:gen-class))

(defn run-for-duration
  "run sketch for a certain duration, then kill"
  [sketch-map sleep-dur]
  (let [papplet (sk/run ((:runner sketch-map)))]
    (Thread/sleep sleep-dur)
(.exit papplet)))

(defn -main [& args]
  (let [sleep-dur 2000]
    (doseq [sketch sk/sketches]
      (run-for-duration sketch sleep-dur)))
  (println "done, bye!")
  (System/exit 0))

