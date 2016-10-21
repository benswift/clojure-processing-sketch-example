(ns exported-sketch-example.sketches
  (:import processing.core.PApplet
           ;; specific sketches
           ExampleSketch RandomCircles))

(defmacro get-runner
  "returns sketch runner function"
  [sketch]
  `(fn []
     (PApplet/runSketch
         (into-array String ["mysketch" "--present"])
         (proxy [~sketch] []
           (exitActual []
             (proxy-super destroy))))))

(def sketches
  [{:uid "u1111111" :runner (get-runner ExampleSketch) :weight 1}
   {:uid "u2222222" :runner (get-runner RandomCircles) :weight 1}])

(def current-sketch
  "start with a random one, because why not?"
  (atom {:uid (:uid (rand-nth sketches))
         :start-time (System/currentTimeMillis)}))

(defn swap-current
  "set current sketch to uid's sketch"
  [uid]
  (reset! current-sketch {:uid uid :start-time (System/currentTimeMillis)}))
