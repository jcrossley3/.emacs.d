(require 'compile)

;;; For maven 2/3 output
(add-to-list 'compilation-error-regexp-alist
             '("^.*?\\(/.*\\):\\[\\([0-9]*\\),\\([0-9]*\\)\\]\\( \\[deprecation\\]\\)?" 1 2 3 (4)))

(defun maven:find-pom (&optional dir) 
  (or dir (setq dir (expand-file-name default-directory)))
  (let ((pom (concat (file-name-as-directory dir) "pom.xml")))
    (cond ((file-exists-p pom)
           pom)
          ((equal dir "/")
           nil)
          (t
           (maven:find-pom (directory-file-name (file-name-directory dir)))))))

(defun maven:set-minus-f-option ()
  (interactive)
  (save-excursion
    (end-of-line)
    (let ((eol (point))
          (pom (maven:find-pom)))
      (beginning-of-line)
      (and pom
           (search-forward "mvn" eol t)
           (if (re-search-forward "-f [^ ]+" eol t)
               (replace-match (concat "-f " pom))
             (insert " -f " pom))))))

