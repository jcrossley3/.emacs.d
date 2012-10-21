;; Setup PATH 
(setenv "PATH" (shell-command-to-string "source ~/.bashrc; echo -n $PATH"))
;; Update exec-path with the contents of $PATH
(setq exec-path (append exec-path (split-string (getenv "PATH") ":")))
;; Grab other environment variables
(loop for var in (split-string (shell-command-to-string "source ~/.bashrc; env")) do
      (let* ((pair (split-string var "="))
	     (key (car pair))
	     (value (cadr pair)))
	(unless (getenv key)
	  (setenv key value))))
