(require 'dash)

(defun export-sketches (source-dir)
  (-each
      (directory-files source-dir :full "^[^.].*[^.]$")
    (lambda (fname)
      (let* ((app-path (format "%s/application.macosx" fname))
             (command (format "processing-java --force --sketch=%s --export --output=%s/export"
                              fname
                              fname)))
        (when (file-directory-p app-path)
          (delete-directory app-path :recursive))
        (message command)
        (shell-command command)))))

(defun find-jars (source-dir)
  (remove-duplicates
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
    (directory-files source-dir "^\\(u[0-9]\\{7\\}\\|Jukebox\\)$"))
   :test (lambda (x y) (string= (file-name-nondirectory x)
                           (file-name-nondirectory y)))))

(defun install-jar (jar-path)
  (let ((command (format "lein localrepo install %s comp1720/%s 0.0.0-SNAPSHOT"
                         jar-path
                         (file-name-base jar-path))))
    (message "[comp1720/%s \"0.0.0-SNAPSHOT\"]" (file-name-base jar-path))
    (shell-command command)))

(defun install-all-jars (source-dir)
  (-each (find-jars source-dir) #'install-jar))

(defun export-and-install (source-dir)
  (export-sketches source-dir)
  (install-all-jars source-dir))

(install-all-jars "/Users/ben/Documents/School/Teaching/comp-1720-2016/major-project/submissions/sketches")

;; this currently doesn't work - should point to the data folders next
;; to the .pde files, not in the src/sketches folder
(defun munge-data-folder-paths (directory base-path)
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

(munge-data-folder-paths "/Users/ben/Code/clojure/clojure-processing-sketch-example/src/sketches"
                         "/Users/ben/Code/clojure/clojure-processing-sketch-example/processing")
