(ns clojure-processing-sketch-example.sketches
  (:import processing.core.PApplet
           ;; specific sketches
           Jukebox u1111111 u2222222 u3333333 u4444444))

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

(def ^{:doc "the applet for the \"Jukebox\" sketch selection screen"}
  jukebox-sketch
  (proxy [Jukebox] []
    (exitActual [])
    (switchToSketch [uid]
      (println "recieved" uid)
      ;; this is where we should start up the requested sketch
      (proxy-super switchToSketch uid))))

(def sketches
  [{:uid "u1111111" :constructor (sketch-proxy u1111111) :weight 1}
   {:uid "u2222222" :constructor (sketch-proxy u2222222) :weight 1}
   {:uid "u3333333" :constructor (sketch-proxy u3333333) :weight 1}
   {:uid "u4444444" :constructor (sketch-proxy u4444444) :weight 1}])

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

(defn run-applet [papplet]
  (PApplet/runSketch
      (into-array String ["mysketch" "--present"])
    papplet)
  papplet)

(defn exit-applet
  ([papplet]
   (.exit papplet))
  ([papplet delay-ms]
   (Thread/sleep delay-ms)
   ;; probably should check it hasn't already been exited before
   ;; calling exit?
   (exit-applet papplet)))
