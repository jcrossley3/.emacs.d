
;;; Keyboard shortcuts
(global-set-key (kbd "C-c m") 'magit-status)
(global-set-key (kbd "C-c b") 'browse-url-at-point)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c f") 'maven:set-minus-f-option)
(global-set-key (kbd "C-c k") 'browse-kill-ring)
(global-set-key (kbd "C-c g") 'rgrep)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c d") 'dictionary-search)

;;; previous input
(defun my-previous-input-behavior ()
  (local-set-key "\M-p" 'comint-previous-matching-input-from-input))
(add-hook 'comint-mode-hook 'my-previous-input-behavior)

