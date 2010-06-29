
;; ensure necessary libs are available on the PATH because MacOS
;; doesn't make this intuitive or easy
(setenv "PATH" (concat (expand-file-name "~/local/maven/bin") ":/opt/local/bin:/opt/local/sbin:" 
		       (getenv "PATH")))


