(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq
   gofmt-command "goimports"
   tab-width 4
   indent-tabs-mode nil)
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; (add-to-list 'load-path(concat (file-name-as-directory (getenv "GOPATH"))
;;                                "src/github.com/mdempsky/gocode/emacs"))
;; (require 'go-autocomplete)
;; (require 'auto-complete-config)
;; (ac-config-default)

(require 'lsp-mode)
(add-hook 'go-mode-hook #'lsp-deferred)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
