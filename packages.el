(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(dash cider clojure-mode magit smex gist browse-kill-ring
                      markdown-mode yaml-mode maxframe adoc-mode ido-ubiquitous
                      auto-complete git-link find-file-in-repository
                      erc-hl-nicks find-things-fast fold-dwim-org
                      rainbow-delimiters org yasnippet
                      better-defaults paredit idle-highlight-mode
                      find-file-in-project scpaste))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

