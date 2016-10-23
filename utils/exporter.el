(defun export-sketches (source-dir dest-dir)
  (-each
      (directory-files source-dir :full "^[^.].*[^.]$")
    (lambda (fname)
      (let ((app-path (format "%s/application.macosx" fname))
            (sketch-name (file-name-nondirectory fname)))
        (when (file-directory-p app-path)
          (delete-directory app-path :recursive))
        (shell-command
         (format "/usr/local/bin/processing-java --force --sketch=%s --export"
                 fname))
        (copy-file (format "%s/source/%s.java" app-path sketch-name)
                   (format "%s/%s.java" dest-dir sketch-name)
                   :overwrite)))))

(export-sketches "/Users/ben/Code/clojure/clojure-processing-sketch-example/processing" "/tmp/sketches")

(defun munge-data-folder-paths (directory)
  (-each
      (directory-files directory :full "java$")
    (lambda (fname)
      (let ((data-path (format "%s/data/%s/" directory (file-name-nondirectory fname))))
        (with-current-buffer (find-file fname)
          (goto-char (point-min))
          (while (re-search-forward "load\\(Image\\|File\\)(\"" nil :noerror)
            (insert data-path)
            (write-file fname))
          (kill-buffer (current-buffer)))))))

(munge-data-folder-paths "/tmp/sketches")
