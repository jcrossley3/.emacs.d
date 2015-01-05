(defun run-shell-command (buf command)
  (with-current-buffer buf
    (goto-char (point-max))
    (insert command)
    (comint-send-input)))

(defun prep-for-preso ()
  (interactive)
  ;; (set-face-font `default "-apple-inconsolata-medium-r-normal--22-0-72-72-m-0-iso10646-1")
  (set-face-font `default "-unknown-DejaVu Sans Mono-normal-normal-normal-*-20-*-*-*-m-0-iso10646-1")
  (yas-global-mode 1)
  (setq nrepl-popup-stacktraces nil
        cider-popup-stacktraces nil)
  (global-auto-complete-mode -1)
  (maximize-frame)
  (shell "*node1*")
  (shell "*node2*")
  (shell "*immutant*")
  (shell "*shell*"))

(defun prep-services ()
  (interactive)
  (run-shell-command "*datomic*" "cd ~/local/datomic; ./bin/transactor config/samples/free-transactor-template.properties")
  (run-shell-command "*node1*" "IMMUTANT_HOME=/tmp/node1 cluster 100")
  (run-shell-command "*node2*" "IMMUTANT_HOME=/tmp/node2 cluster 200"))

;;; put the paredit in the repl
(add-hook 'slime-repl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;;; history file
(setq nrepl-history-file "~/.nrepl-history.eld")
(setq cider-repl-history-file "~/.nrepl-history.eld")

;;; datomic schema files
(add-to-list 'auto-mode-alist '("\\.dtm$" . clojure-mode))

;;; folding
(add-hook 'clojure-mode-hook 
          (lambda () 
            (hs-minor-mode)
            (fold-dwim-org/minor-mode)
            (local-set-key (kbd "C-c TAB") 'fold-dwim-org/minor-mode)))

;;; Fix clojure-test-mode
(require 'clojure-test-mode)
(defalias 'nrepl-emit-interactive-output 'cider-emit-interactive-output)

(require 'cider)
(defun run-cider-command (buf command)
  (with-current-buffer buf
    (goto-char (point-max))
    (insert-char ?\n)
    (insert command)
    (cider-repl-return)))

(defun send-expr-to-repl ()
  (interactive)
  (run-cider-command "*cider*" (cider-expression-at-point)))
