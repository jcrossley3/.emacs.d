(require 'org)
(require 'ob)
(require 'ob-tangle)

(setq
 org-babel-load-languages (quote ((ruby . t) (clojure . t) (emacs-lisp . t)))
 org-hide-leading-stars   t
 org-src-fontify-natively t
 org-startup-folded       nil)
