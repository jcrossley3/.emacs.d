(require 'cl)

;; Setup PATH 
(setenv "PATH" (shell-command-to-string "source ~/.bashrc; echo -n $PATH"))
;; Update exec-path with the contents of $PATH
(setq exec-path (append exec-path (split-string (getenv "PATH") ":")))
;; Grab other environment variables
(loop for var in (split-string (shell-command-to-string "source ~/.bashrc; env") "\n") do
      (if (string-match "\\(.*?\\)=\\(.*\\)" var)
          (let ((key (match-string 1 var))
                (val (match-string 2 var)))
            (unless (getenv key)
              (setenv key val)))))
