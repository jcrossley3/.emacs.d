;;; Stuff for programming

(defun jc:local-column-number-mode ()
  (make-local-variable 'column-number-mode)
  (column-number-mode t))

(defun jc:local-comment-auto-fill ()
  (set (make-local-variable 'comment-auto-fill-only-comments) t)
  (auto-fill-mode t))

(defun jc:turn-on-hl-line-mode ()
  (when (> (display-color-cells) 8)
    (hl-line-mode t)))

(defun jc:turn-on-save-place-mode ()
  (require 'saveplace)
  (setq save-place t))

(defun jc:turn-on-idle-highlight-mode ()
  (idle-highlight-mode t))

(defun jc:pretty-lambdas ()
  (font-lock-add-keywords
   nil `(("(?\\(lambda\\>\\)"
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))

(defun jc:add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\|NOCOMMIT\\)"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'jc:local-column-number-mode)
(add-hook 'prog-mode-hook 'jc:local-comment-auto-fill)
(add-hook 'prog-mode-hook 'jc:turn-on-hl-line-mode)
(add-hook 'prog-mode-hook 'jc:turn-on-save-place-mode)
(add-hook 'prog-mode-hook 'jc:pretty-lambdas)
(add-hook 'prog-mode-hook 'jc:add-watchwords)
(add-hook 'prog-mode-hook 'jc:turn-on-idle-highlight-mode)

(defun jc:prog-mode-hook ()
  (run-hooks 'prog-mode-hook))

(defun jc:turn-off-tool-bar ()
  (tool-bar-mode -1))

(defun jc:untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun jc:indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun jc:cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (jc:indent-buffer)
  (jc:untabify-buffer)
  (delete-trailing-whitespace))

(defun jc:sudo-edit (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun jc:paredit-nonlisp ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))

;; A monkeypatch to cause annotate to ignore whitespace
(defun vc-git-annotate-command (file buf &optional rev)
  (let ((name (file-relative-name file)))
    (vc-git-command buf 0 name "blame" "-w" rev)))

