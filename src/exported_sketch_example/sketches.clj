(ns exported-sketch-example.sketches
  (:import processing.core.PApplet
           ;; specific sketches
           Jukebox ExampleSketch RandomCircles MinimPlayPause))

(defmacro sketch-proxy
  "create sketch proxy"
  [sketch]
  `(fn []
     (proxy [~sketch] []
       (exitActual []))))

(defn run
  "run sketch"
  [sketch]
  (PApplet/runSketch
      (into-array String ["mysketch" "--present"])
      sketch)
  sketch)

(defn run-for-duration
  "run sketch for a certain duration, then kill"
  [sketch-map sleep-dur]
  (let [papplet (run ((:runner sketch-map)))]
    (Thread/sleep sleep-dur)
    (.exit papplet)))

(def sketches
  [{:uid "u1111111" :runner (sketch-proxy ExampleSketch) :weight 1}
   {:uid "u2222222" :runner (sketch-proxy RandomCircles) :weight 1}
   {:uid "u3333333" :runner (sketch-proxy MinimPlayPause) :weight 1}
   {:uid "u4444444" :runner (sketch-proxy Jukebox) :weight 1}])

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
