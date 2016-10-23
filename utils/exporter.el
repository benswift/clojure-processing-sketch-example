(defun export-sketches (source-dir dest-dir)
  (-each
      (directory-files source-dir :full "[^.]$")
    (lambda (fname)
      (shell-command
       (format "/usr/local/bin/processing-java --force --sketch=%s --export"
               fname))
      (copy-file (format "%s/application.macosx/source/%s.java" fname (file-name-nondirectory fname))
                 (format "%s/%s.java" dest-dir (file-name-nondirectory fname))
                 :overwrite))))

(export-sketches "/Users/ben/Code/clojure/exported-sketch-example/processing" "/tmp/sketches")

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
