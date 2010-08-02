(require 'compile)

(defvar mvn-command-history nil
  "Maven command history variable")

(defun mvn(&optional args) 
  "Searches up the path for a pom.xml"
  (interactive)
  (let* ((dir (file-name-as-directory (expand-file-name default-directory)))
	 (found (file-exists-p (concat dir "pom.xml"))))
    (while (and (not found) (not (equal dir "/")))
      (setq dir (file-name-as-directory (expand-file-name (concat dir "..")))
            found (file-exists-p (concat dir "pom.xml"))))
    (if (not found)
        (message "No pom.xml found")
      (compile (read-from-minibuffer "Command: " 
                                     (concat "mvn -f " dir "pom.xml test") nil nil 'mvn-command-history)))))

;;; For maven 2/3 output
(add-to-list 'compilation-error-regexp-alist
             '("^\\(.*\\):\\[\\([0-9]*\\),\\([0-9]*\\)\\]" 1 2 3))
