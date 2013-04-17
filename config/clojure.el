(defun run-command (buf command)
  (with-current-buffer buf
    (goto-char (point-max))
    (insert command)
    (comint-send-input)))

(defun prep-for-preso ()
  (interactive)
  (set-face-font `default "-apple-inconsolata-medium-r-normal--22-0-72-72-m-0-iso10646-1")
  (yas-global-mode 1)
  (setq nrepl-popup-stacktraces nil)
  (global-auto-complete-mode -1)
  (maximize-frame)
  (shell "*node1*")
  (shell "*node2*")
  (shell "*immutant*")
  (shell "*shell*"))

(defun prep-services ()
  (interactive)
  (run-command "*datomic*" "cd ~/local/datomic; ./bin/transactor config/samples/free-transactor-template.properties")
  (run-command "*node1*" "IMMUTANT_HOME=/tmp/node1 cluster 100")
  (run-command "*node2*" "IMMUTANT_HOME=/tmp/node2 cluster 200"))

;;; put the paredit in the repl
(add-hook 'slime-repl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)

;;; nrepl config
(setq nrepl-history-file "~/.nrepl-history.eld")

;;; datomic schema files
(add-to-list 'auto-mode-alist '("\\.dtm$" . clojure-mode))

;;; folding
(add-hook 'clojure-mode-hook 
          (lambda () 
            (hs-minor-mode)
            (fold-dwim-org/minor-mode)
            (local-set-key (kbd "C-c TAB") 'fold-dwim-org/minor-mode)))
