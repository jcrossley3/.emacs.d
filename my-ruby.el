
(defun ri-bind-key ()
  (local-set-key [f1] 'yari))
(add-hook 'ruby-mode-hook 'ri-bind-key)

;;; apparently inf-ruby doesn't fire the comint-mode-hook
(add-hook 'inf-ruby-mode-hook 'my-previous-input-behavior)

(add-to-list 'auto-mode-alist '("\\.gem\\'" . tar-mode))


(require 'rinari)
(rinari-bind-key-to-func "l" (quote 'open-log))
(defun open-log (log-file)
  (interactive
   (list (completing-read "Choose log: "
                          (directory-files (concat (rinari-root) "log") nil "\\.log$")
                          nil
                          t)))
  (let ((name (log-buffer-name log-file)))
    (unless (get-buffer name)
      (buffer-log-file log-file))
    (switch-to-buffer name)
    (recenter t)))
(defun log-buffer-name (log-file)
  (concat "*" (car (last (split-string (rinari-root) "/" t))) "/" log-file "*"))
(defun buffer-log-file (log-file)
  (let ((buffer (log-buffer-name log-file)))
    (unless (get-buffer buffer)
      (with-current-buffer (get-buffer-create buffer)
        (setq auto-window-vscroll t)
        (setq buffer-read-only t)
        (rinari-minor-mode)
        (make-local-variable 'after-change-functions)
        (add-hook 'after-change-functions
                  '(lambda (start end len)
                     (ansi-color-apply-on-region start end)))))
    (start-process "tail"
                   buffer
                   "tail"
                   "-F" (expand-file-name (concat (rinari-root) "log/" log-file)))))
