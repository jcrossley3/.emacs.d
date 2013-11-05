(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(dash cider clojure-mode clojure-test-mode
                      notify gist twittering-mode browse-kill-ring
                      markdown-mode yaml-mode maxframe adoc-mode
                      jtags jtags-extras auto-complete github-browse-file
                      erc-hl-nicks find-things-fast fold-dwim-org
                      rainbow-delimiters org yasnippet
                      starter-kit starter-kit-bindings starter-kit-lisp))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

