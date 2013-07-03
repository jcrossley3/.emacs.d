(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(clojure-mode clojure-test-mode
                      notify gist twittering-mode browse-kill-ring
                      markdown-mode yaml-mode maxframe adoc-mode
                      jtags jtags-extras auto-complete
                      erc-hl-nicks find-things-fast fold-dwim-org
                      rainbow-delimiters org yasnippet
                      starter-kit starter-kit-bindings starter-kit-lisp))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

