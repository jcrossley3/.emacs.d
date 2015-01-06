;; install any needed packages
(load (concat user-emacs-directory "packages"))

;; keep customize settings in their own file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; load private data - this doesn't go into git
(load "~/.emacs.d/private.el.gpg")

;;; load my config
(let ((dir (concat user-emacs-directory "config")))
  (mapc 'load (directory-files dir t "^[^#].*el$")))

;;; something seems to append things here

;(setq auth-source-debug t)
(put 'narrow-to-region 'disabled nil)
