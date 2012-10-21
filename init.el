(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit
                      starter-kit-lisp starter-kit-ruby starter-kit-bindings
                      clojure-mode clojure-test-mode
                      notify gist twittering-mode
                      markdown-mode yaml-mode maxframe
                      jtags jtags-extras auto-complete
                      erc-hl-nicks ac-slime))
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; keep customize settings in their own file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; auto-complete
(require 'auto-complete-config)
(ac-config-default)

;;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

;;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(load "~/.emacs.d/.auth.el")            ;;; slurp in various credentials

(load "~/.emacs.d/config/env.el")
(load "~/.emacs.d/config/erc.el")
(load "~/.emacs.d/config/tags.el")
(load "~/.emacs.d/config/maven.el")
(load "~/.emacs.d/config/twitter.el")
(load "~/.emacs.d/config/bindings.el")


(put 'ido-exit-minibuffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)
