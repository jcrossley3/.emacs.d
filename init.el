;; My emacs configuration

;; make any elisp files in here available on load-path
(setq my-config-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path my-config-dir)
(add-to-list 'load-path (concat my-config-dir "lib"))

;; keep customize settings in their own file
(setq custom-file (concat my-config-dir "custom.el"))
(load custom-file)

;; slurp in my various credentials
(load ".auth")

;; elpa
(require 'package)
(package-initialize)

;; my stuff
(load "my-env")
(load "my-twitter")
(load "my-ruby")
(load "my-java")
(load "my-irc")
(load "my-nxml")
(put 'narrow-to-region 'disabled nil)
