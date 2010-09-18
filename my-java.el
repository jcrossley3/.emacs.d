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

;;; TAGS setup
(setq tags-table-list '(
                        "~/src/torquebox"
                        "~/src/jboss-deployers"
                        "~/local/java/src"
                        ))
(setq tags-revert-without-query 't)

(add-hook 'java-mode-hook 'jtags-mode)
(autoload 'jtags-mode "jtags")

(require 'cl)
(defun common-prefix (s1 s2)
  "Find the longest prefix common to both strings"
  (let ((cnt (compare-strings s1 nil nil s2 nil nil)))
    (if (> cnt 0)
		(substring s1 0 (- cnt 1))
      (substring s1 0 (- -1 cnt)))))
(defun common-prefix-all (&rest args)
  (reduce 'common-prefix args))

(defun common-prefix-recur (s1 &rest args)
  (cond ((= 1 (length args))
		 (let* ((s2 (car args))
				(cnt (compare-strings s1 nil nil s2 nil nil)))
		   (if (> cnt 0)
			   (substring s1 0 (- cnt 1))
			 (substring s1 0 (- -1 cnt)))))
		((= 0 (length args))
		 s1)
		((apply 'common-prefix-recur (common-prefix-recur s1 (car args)) (cdr args)))))
