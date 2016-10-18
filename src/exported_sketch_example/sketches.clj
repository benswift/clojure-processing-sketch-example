(ns exported-sketch-example.sketches
  (:import ExampleSketch RandomCircles processing.core.PApplet))

(defmacro create-proxy [sketch-class]
  `(proxy [~sketch-class] []
     (exitActual [] (println "exiting... not really."))))

(defn create-all []
  [{:uid "u1234567" :applet (create-proxy ExampleSketch) :weight 1}
   {:uid "u2345678" :applet (create-proxy RandomCircles) :weight 1}])

(defn run [{:keys [uid applet weight]}]
  (PApplet/runSketch
      (into-array String [uid])
    applet))

