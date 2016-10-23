(defproject exported-sketch-example "0.1.0-SNAPSHOT"
  :description "manage exported processing sketches from Quil"
  :url "https://github.com/benswift/quil-exported-sketch-example"
  :main exported-sketch-example.core
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [org.processing/core "3.2.1"]
                 [ddf.minim "2.2.0"]
                 ;; probably want this too - https://github.com/clojure/tools.cli
                 ]
  :java-source-paths ["src/sketches"]
  :plugins [[lein-localrepo "0.5.3"]])
