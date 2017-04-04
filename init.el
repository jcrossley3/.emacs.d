;; install any needed packages

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

;;; Initialization without a home
(put 'narrow-to-region 'disabled nil)
