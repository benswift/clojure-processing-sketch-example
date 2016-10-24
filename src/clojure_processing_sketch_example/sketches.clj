(ns clojure-processing-sketch-example.sketches
  (:import processing.core.PApplet
           ;; specific sketches
           u4444444))

;; keys should be [papplet time]
(def current-sketch
  (atom {}))

(defn touch-current-time
  "'touch' sketch with current time"
  []
  (swap! current-sketch assoc :time (System/currentTimeMillis)))

(defmacro sketch-proxy
  [applet-subclass]
  (let [event-sym (gensym "event")]
    `(fn []
       (proxy [~applet-subclass] []
         (exitActual [])
         (handleKeyEvent [~event-sym]
           (touch-current-time)
           (proxy-super handleKeyEvent ~event-sym))
         (handleMouseEvent [~event-sym]
           (touch-current-time)
           (proxy-super handleMouseEvent ~event-sym))))))

(def sketches
  [{:uid "u4444444" :constructor (sketch-proxy u4444444) :weight 1}])

(defn set-current
  [papplet]
  (reset!
   current-sketch
   {:papplet papplet
    :time (System/currentTimeMillis)}))

(defn set-random
  [uid]
  (reset!
   current-sketch
   {:papplet (:constructor (rand-nth sketches))
    :time (System/currentTimeMillis)}))

(defn run [papplet]
  (PApplet/runSketch
      (into-array String ["mysketch" "--present"])
    papplet)
  papplet)

(defn stop
  ([papplet]
   (.exit papplet))
  ([papplet delay-ms]
   (Thread/sleep delay-ms)
   ;; probably should check it hasn't already been exited before
   ;; calling exit?
   (.exit papplet)))
