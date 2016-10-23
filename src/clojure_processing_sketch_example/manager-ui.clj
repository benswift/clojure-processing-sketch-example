(ns clojure-processing-sketch-example.manager-ui
  (:require [quil.core :as q]
            [quil.middleware :as m]
            [clojure-processing-sketch-example.sketches :as sk]))

(defn setup []
  (q/background 255)
  {:scene 0})

(defn update-state [state]
  state)

(defn draw-state [state]
  (q/no-stroke)
  (q/background 255)
  (q/fill 0)
  (q/ellipse (/ (q/random q/width) 2)
             (/ (q/random q/height) 2)
             100 100)
  (if (= (% q/frame-count 30) 0)
    (sk/run (first (shuffle (sk/create-all))))))

(q/defsketch ui
  :size :fullscreen
  :setup setup
  :update update-state
  :draw draw-state
  :middleware [m/fun-mode])
