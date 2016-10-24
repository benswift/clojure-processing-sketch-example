(require 'dash)

(defun export-sketches (source-dir dest-dir)
  (-each
      (directory-files source-dir :full "^[^.].*[^.]$")
    (lambda (fname)
      (let ((app-path (format "%s/application.macosx" fname)))
        (when (file-directory-p app-path)
          (delete-directory app-path :recursive))
        (shell-command
         (format "/usr/local/bin/processing-java --force --sketch=%s --export"
                 fname))))))

(export-sketches "/Users/ben/Code/clojure/clojure-processing-sketch-example/processing" "/Users/ben/Code/clojure/clojure-processing-sketch-example/src/sketches")

(defun find-jars (source-dir)
  (-uniq
   (-mapcat
    (lambda (sketch-folder)
      (-filter
       (lambda (jar) (and (not (s-contains? "/jre/" jar))
                     (not (member (file-name-nondirectory jar)
                                  '("core.jar"
                                    "gluegen-rt-natives-macosx-universal.jar"
                                    "gluegen-rt.jar"
                                    "jogl-all-natives-macosx-universal.jar"
                                    "jogl-all.jar")))))
       (directory-files-recursively sketch-folder "jar$")))
   
    (directory-files source-dir "^u[0-9]\\{7\\}$"))))

(defun install-jar (jar-path)
  (shell-command (format "lein localrepo install %s comp1720/%s 0.0.0-SNAPSHOT"
                         jar-path
                         (file-name-base jar-path))))

(defun install-all-jars (source-dir)
  (-each (find-jars source-dir) #'install-jar))

(install-all-jars "/Users/ben/Code/clojure/clojure-processing-sketch-example/processing")

;; this currently doesn't work - should point to the data folders next
;; to the .pde files, not in the src/sketches folder
(defun munge-data-folder-paths (directory)
  (-each
      (directory-files directory :full "pde$")
    (lambda (fname)
      (let ((data-path (format "%s/data/%s/" directory (file-name-nondirectory fname))))
        (with-current-buffer (find-file fname)
          (goto-char (point-min))
          (while (re-search-forward "load\\(Image\\|File\\)(\"" nil :noerror)
            (insert data-path)
            (write-file fname))
          (kill-buffer (current-buffer)))))))

(munge-data-folder-paths "/Users/ben/Code/clojure/clojure-processing-sketch-example/src/sketches")
