(ns clojure-processing-sketch-example.core
  (:require [clojure-processing-sketch-example.sketches :as sk])
  (:gen-class))

(defn -main [& args]
  (let [sleep-dur 2000]
    ;; (sk/stop (sk/run sk/jukebox-sketch) sleep-dur)
    (sk/start)
    (Thread/sleep sleep-dur)
    (sk/start)
    (Thread/sleep sleep-dur))
  (println "done, bye!")
  (System/exit 0))

