(ns clojure-processing-sketch-example.core
  (:require [clojure-processing-sketch-example.sketches :as sk])
  (:import Jukebox)
  (:gen-class))

(defn -main [& args]
  (let [sleep-dur 2000]
    (doseq [sketch sk/sketches]
      (sk/run-for-duration sketch sleep-dur)))
  (sk/run sk/jukebox-sketch)
  (Thread/sleep 10000)
  (println "done, bye!")
  (System/exit 0))

