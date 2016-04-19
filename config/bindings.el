

(global-set-key (kbd "M-/") 'hippie-expand)

;; Jump to a definition in the current file. (Protip: this is awesome.)
(global-set-key (kbd "C-x C-i") 'imenu)

;; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)

;; Window switching. (C-x o goes to the next window)
(windmove-default-keybindings) ;; Shift+direction
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Start a regular shell if you prefer that.
(global-set-key (kbd "C-x C-m") 'shell)

;; If you want to be able to M-x without meta (phones, etc)
(global-set-key (kbd "C-c x") 'execute-extended-command)

;; Help should search more than just commands
(global-set-key (kbd "C-h a") 'apropos)

;; M-S-6 is awkward
(global-set-key (kbd "C-c q") 'join-line)

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;;; Keyboard shortcuts
(global-set-key (kbd "M-x")   'smex)
(global-set-key (kbd "C-c m") 'magit-status)
(global-set-key (kbd "C-c b") 'browse-url-at-point)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c f") 'maven:set-minus-f-option)
(global-set-key (kbd "C-c k") 'browse-kill-ring)
(global-set-key (kbd "C-c g") 'rgrep)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c d") 'dictionary-search)
(global-set-key (kbd "C-x f") 'ftf-find-file)
;; (global-set-key (kbd "C-x f") 'find-file-in-repository)
(global-set-key (kbd "C-c t") 'jc/erc-reset-track-mode)


;;; previous input
(defun my-previous-input-behavior ()
  (local-set-key "\M-p" 'comint-previous-matching-input-from-input))
(add-hook 'comint-mode-hook 'my-previous-input-behavior)

(fset 'inrepl
      [?\C-r ?s ?t ?a ?r ?t ?i ?n ?g ?  ?n ?r ?e ?p ?l ?\C-m ?\C-s ?: ?\C-m ?\M-@ ?\M-w ?\M-x ?n ?r ?e ?p ?l return return ?\C-y return])
