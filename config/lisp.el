
(defun jc:turn-on-paredit ()
  (paredit-mode t))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'jc:remove-elc-on-save)
(add-hook 'emacs-lisp-mode-hook 'jc:prog-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)

(defun jc:remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

(define-key emacs-lisp-mode-map (kbd "C-c v") 'eval-buffer)

;;; Enhance Lisp Modes

(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)

;; TODO: look into parenface package
(defface jc:paren-face
  '((((class color) (background dark))
     (:foreground "grey50"))
    (((class color) (background light))
     (:foreground "grey55")))
  "Face used to dim parentheses."
  :group 'starter-kit-faces)

(eval-after-load 'paredit
  '(define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp))

(dolist (mode '(scheme emacs-lisp lisp clojure))
  (when (> (display-color-cells) 8)
    (font-lock-add-keywords (intern (concat (symbol-name mode) "-mode"))
                            '(("(\\|)" . 'jc:paren-face))))
  (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
            'jc:turn-on-paredit)
  (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
            'jc:turn-on-paredit))

(defun jc:pretty-fn ()
  (font-lock-add-keywords nil `(("(\\(fn\\>\\)"
                                 (0 (progn (compose-region (match-beginning 1)
                                                           (match-end 1)
                                                           "\u0192") nil))))))
(add-hook 'clojure-mode-hook 'jc:pretty-fn)

