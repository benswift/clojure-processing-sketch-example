(ns exported-sketch-example.core
  (:require [exported-sketch-example.sketches :as sk])
  (:gen-class))

(defn -main [& args]
  (let [sleep-dur 2000]
    (doseq [sketch sk/sketches]
      (sk/run-for-duration sketch sleep-dur)))
  (println "done, bye!")
  (System/exit 0))

