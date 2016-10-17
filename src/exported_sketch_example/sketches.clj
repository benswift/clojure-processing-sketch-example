(ns exported-sketch-example.sketches
  (:import ExampleSketch RandomCircles processing.core.PApplet))

(defn create-all []
  [{:uid "u1234567" :applet (ExampleSketch.) :weight 1}
   {:uid "u2345678" :applet (RandomCircles.) :weight 1}])

(defn run [{:keys [uid applet weight]}]
  (PApplet/runSketch
      (into-array String [uid])
    applet))

(defn testone [{:keys [uid applet weight]}]
  (println uid applet weight))

(testone (keys (take 1 (create-all))))

(keys (do (take 1 (create-all))))

(keys {:a 1 :b 2})

(type ( (create-all)))
