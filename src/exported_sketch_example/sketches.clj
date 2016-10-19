(ns exported-sketch-example.sketches
  (:import processing.core.PApplet
           ;; processing.app.Sketch
           ;; processing.mode.java.JavaBuild
           ;; specific sketches
           ExampleSketch RandomCircles))

(defn run-example-sketch []
  (PApplet/runSketch
      (into-array String ["mysketch" "--present"])
      (proxy [ExampleSketch] []
        (exitActual []
          (println "seeya mate!")
          (proxy-super destroy)))))

(defn run-random-circles []
  (PApplet/runSketch
      (into-array String ["mysketch" "--present"])
      (proxy [RandomCircles] []
        (exitActual []
          (println "seeya mate!")
          (proxy-super destroy)))))

;; ;; what should the Mode be?
;; ;; (defn export-java [folder]
;; ;;   (.preprocess (JavaBuild. (Sketch. mode))))

;; (defmacro create-proxy [sketch-class]
;;   `(proxy [~sketch-class] []
;;      (handleKeyEvent [event]
;;        (println "keyPressed")
;;        ;; (when (= (.getKeyCode event) 0)
;;        ;;   (.setKeyCode event 0))
;;        ;; (proxy-super event)
;;        )
;;      (exitActual []
;;        (println "exiting... not really."))))

;; (defn create-all []
;;   [{:uid "u1234567" :applet (create-proxy ExampleSketch) :weight 1}
;;    {:uid "u2345678" :applet (create-proxy RandomCircles) :weight 1}])

;; (defn run [{:keys [uid applet weight]}]
;;   (PApplet/runSketch
;;       (into-array String [uid "--present"])
;;     applet))
