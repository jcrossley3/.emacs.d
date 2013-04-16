
;;; Keyboard shortcuts
(global-set-key (kbd "C-c m") 'magit-status)
(global-set-key (kbd "C-c b") 'browse-url-at-point)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c f") 'maven:set-minus-f-option)
(global-set-key (kbd "C-c k") 'browse-kill-ring)
(global-set-key (kbd "C-c g") 'rgrep)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c d") 'dictionary-search)
(global-set-key (kbd "C-x f") 'ftf-find-file)

;;; previous input
(defun my-previous-input-behavior ()
  (local-set-key "\M-p" 'comint-previous-matching-input-from-input))
(add-hook 'comint-mode-hook 'my-previous-input-behavior)

(fset 'inrepl
   [?\C-r ?s ?t ?a ?r ?t ?i ?n ?g ?  ?n ?r ?e ?p ?l ?\C-m ?\C-s ?: ?\C-m ?\M-@ ?\M-w ?\M-x ?n ?r ?e ?p ?l return return ?\C-y return])
