(ns clojure-processing-sketch-example.sketches
  (:import processing.core.PApplet Jukebox)
  (:require [clojure.java.shell :refer [sh]]))

(def sketches
  (atom []))

(def current-sketch
  (atom {}))

(defn current-papplet []
  (:papplet @current-sketch))

(defn current-idle-time []
  (/ (- (System/currentTimeMillis) (:time @current-sketch)) 1000.0))

(defn touch-current-time
  "'touch' sketch with current time"
  []
  (swap! current-sketch assoc :time (System/currentTimeMillis)))

(defn run-papplet [papplet]
  (PApplet/runSketch
      (into-array String ["mysketch" "--present"])
      papplet)
  papplet)

(defn exit-papplet
  ([papplet]
   (.exit papplet))
  ([papplet delay-ms]
   (Thread/sleep delay-ms)
   ;; probably should check it hasn't already been exited before
   ;; calling exit?
   (.exit papplet)))

(defn sketch-for-uid [uid]
  (first (filter  #(= (:uid %) uid) @sketches)))

(defn start
  ([]
   (start (->> @sketches (map :uid) rand-nth)))
  ([uid]
   (reset!
    current-sketch
    {:papplet (run-papplet ((:constructor (sketch-for-uid uid))))
     :time (System/currentTimeMillis)})))

(defn jukebox-proxy []
  (fn []
    (proxy [Jukebox] []
      (exitActual []
        (println "jukebox recieved exitActual"))
      (switchToSketch [uid]
        (println "switching to " uid)
        (start uid))
      (handleKeyEvent [event]
        (touch-current-time)
        (proxy-super handleKeyEvent event))
      (handleMouseEvent [event]
        (touch-current-time)
        (proxy-super handleMouseEvent event)))))

(defn start-jukebox
  ([]
   (reset!
    current-sketch
    {:papplet (run-papplet ((jukebox-proxy)))
     :time (System/currentTimeMillis)})))

(def juke ((jukebox-proxy)))

(defmacro sketch-proxy
  [papplet-subclass]
  (let [event-sym (gensym "event")]
    `(fn []
       (proxy [~papplet-subclass] []
         (exitActual []
           (println "sketch recieved exitActual")
           (start-jukebox))
         (handleKeyEvent [~event-sym]
           (touch-current-time)
           (proxy-super handleKeyEvent ~event-sym))
         (handleMouseEvent [~event-sym]
           (touch-current-time)
           (proxy-super handleMouseEvent ~event-sym))))))

(defn gallery-loop [idle-time]
  (loop []
    (when (> (current-idle-time) idle-time)
      (.exit (current-papplet))
      (if (instance? Jukebox 
                     (current-papplet))
        (start)
        (do
          (.exit (current-papplet))
          (start-jukebox))))
    (Thread/sleep 1000)
    (recur)))

(defn init []
  (reset! sketches
          [{:uid "u1111111" :constructor (sketch-proxy u1111111) :weight 1}
           {:uid "u2222222" :constructor (sketch-proxy u2222222) :weight 1}
           ;; {:uid "u3333333" :constructor (sketch-proxy u3333333) :weight 1}
           ;; {:uid "u4444444" :constructor (sketch-proxy u4444444) :weight 1}
           ])
  (start-jukebox))
