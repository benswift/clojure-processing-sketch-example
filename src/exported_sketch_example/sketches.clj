(ns exported-sketch-example.sketches
  (:import processing.core.PApplet
           ;; specific sketches
           ExampleSketch RandomCircles MinimPlayPause))

(defmacro sketch-proxy
  "create sketch proxy"
  [sketch]
  `(fn []
     (proxy [~sketch] []
       (exitActual []
         (proxy-super destroy)))))

(defn run
  "run sketch"
  [sketch]
  (PApplet/runSketch
      (into-array String ["mysketch" "--present"])
      sketch)
  sketch)

(def sketches
  [{:uid "u1111111" :runner (sketch-proxy ExampleSketch) :weight 1}
   {:uid "u2222222" :runner (sketch-proxy RandomCircles) :weight 1}
   {:uid "u3333333" :runner (sketch-proxy MinimPlayPause) :weight 1}])

(def current-sketch
  "start with a random one, because why not?"
  (atom {:uid (:uid (rand-nth sketches))
         :start-time (System/currentTimeMillis)}))

(def current-sketch
  (atom {}))

(defn set-current
  "set current sketch to uid's sketch"
  [uid]
  (reset!
   current-sketch
   {:uid uid
    :start-time (System/currentTimeMillis)}))

(defn set-random
  "set current sketch to uid's sketch"
  [uid]
  (reset!
   current-sketch
   {:uid (:uid (rand-nth sketches))
    :start-time (System/currentTimeMillis)}))
