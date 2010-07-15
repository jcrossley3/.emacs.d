
(require 'rinari)

(require 'yari)
(defun ri-bind-key ()
  (local-set-key [f1] 'yari))
(add-hook 'ruby-mode-hook 'ri-bind-key)

;;; apparently inf-ruby doesn't fire the comint-mode-hook
(add-hook 'inf-ruby-mode-hook 'my-previous-input-behavior)

;;; Another ri alternative
;; (setq ri-ruby-script (concat config-dir "ri-emacs/ri-emacs.rb"))
;; (autoload 'ri (concat config-dir "ri-emacs/ri-ruby.el") nil t)
;; (add-hook 'ruby-mode-hook (lambda ()
;; 			    (local-set-key 'f1 'ri)
;; 			    (local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)
;; 			    (local-set-key 'f4 'ri-ruby-show-args)
;; 			    ))

(add-to-list 'auto-mode-alist '("\\.gem\\'" . tar-mode))
