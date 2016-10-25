(defproject clojure-processing-sketch-example "0.1.0-SNAPSHOT"
  :description "manage exported processing sketches from clojure"
  :url "https://github.com/benswift/clojure-processing-sketch-example"
  :main clojure-processing-sketch-example.core
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [org.processing/core "3.2.1"]
                 [comp1720/tritonus_share "0.0.0-SNAPSHOT"]
                 [comp1720/jsminim "0.0.0-SNAPSHOT"]
                 [comp1720/u4444444 "0.0.0-SNAPSHOT"]
                 [comp1720/u3333333 "0.0.0-SNAPSHOT"]
                 [comp1720/u2222222 "0.0.0-SNAPSHOT"]
                 [comp1720/Jukebox "0.0.0-SNAPSHOT"]
                 [comp1720/u1111111 "0.0.0-SNAPSHOT"]
                 [comp1720/minim "0.0.0-SNAPSHOT"]
                 [comp1720/mp3spi1.9.5 "0.0.0-SNAPSHOT"]
                 [comp1720/jl1.0.1 "0.0.0-SNAPSHOT"]
                 [comp1720/tritonus_aos "0.0.0-SNAPSHOT"]
                 ;; probably want this too - https://github.com/clojure/tools.cli
                 ]
  :java-source-paths ["src/sketches"]
  :plugins [[lein-localrepo "0.5.3"]])
