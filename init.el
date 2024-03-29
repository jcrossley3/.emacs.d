
;; Initialize package system
(require 'package)
(setq package-archives
      '(("org"     .       "https://orgmode.org/elpa/")
        ("gnu"     .       "https://elpa.gnu.org/packages/")
        ("melpa"   .       "https://melpa.org/packages/")))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; use-package for civilized configuration
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; keep customize settings in their own file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; load private data - this doesn't go into git
(load "~/.emacs.d/private.el.gpg")

;; avoid typing yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

(use-package which-key
  :diminish
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom)
  (setq which-key-idle-delay 0.1))

(use-package adoc-mode)

(use-package diminish
  :defer 5
  :config
  (diminish 'org-indent-mode))

(use-package magit
  :bind ("C-c m" . magit-status))

(use-package forge)

(use-package swiper
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(use-package selectrum
  :config
  (selectrum-mode +1))
(use-package selectrum-prescient
  :config
  (selectrum-prescient-mode +1)
  (prescient-persist-mode +1))
(use-package orderless
  :ensure t
  :custom (completion-styles '(orderless)))

(use-package go-mode
  :bind ("C-c c" . compile)
  :config
  (defun my-go-mode-hook ()
    (setq
     tab-width 4
     indent-tabs-mode nil)
    (if (not (string-match "go" compile-command))
      (setq-local compile-command "go build -v && go test -v && go vet")))
  (add-hook 'go-mode-hook 'my-go-mode-hook))

(use-package markdown-mode)
(use-package yaml-mode)
(use-package gist)
(use-package git-link)
(use-package org)

(use-package browse-kill-ring
  :bind ("C-c k" . browse-kill-ring))

(use-package browse-url
  :bind ("C-c b" . browse-url-at-point))

(use-package find-file-in-project
  :bind ("C-x f" . find-file-in-project))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

(use-package shell
  :bind ("C-x C-m" . shell))

(use-package grep
  :bind ("C-c g" . rgrep))

(use-package comint
  :ensure nil
  :bind (:map comint-mode-map
	      ("M-p" . comint-previous-matching-input-from-input)))

(use-package term
  :ensure nil
  :bind (:map term-raw-map
	      ("M-x" . execute-extended-command))
  :config
  (defun my-term-simple-send-with-crlf (proc string)
    (term-send-string proc string)
    (term-send-string proc "\r\n"))
  (add-hook 'term-mode-hook
	    (lambda ()
	      (setq-local term-input-sender #'my-term-simple-send-with-crlf))))

(use-package ansi-color
  :config
  (add-hook 'compilation-filter-hook #'colorize-compilation-buffer))

(defun colorize-compilation-buffer ()
  (when (derived-mode-p 'compilation-mode)
    (ansi-color-process-output nil)
    (setq-local comint-last-output-start (point-marker))))

;; rust
(load "~/.emacs.d/config/rust.el")

;; TODO: deal with erc betterer
(use-package erc-hl-nicks)
(load "~/.emacs.d/config/irc.el")
