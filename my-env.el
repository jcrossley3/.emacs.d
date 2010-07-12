;;; does anyone really use this?
(tool-bar-mode -1)

;;; a nice font perhaps?
(set-frame-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1" nil)

;;; ooh, colors!
(if (require 'color-theme nil t)
    (progn
      (if (fboundp 'color-theme-initialize) (color-theme-initialize))
      ;; (color-theme-jsc-dark)
      ;; (color-theme-dark-blue)
      ;; (color-theme-subtle-hacker)
      ;; (color-theme-ld-dark)
      ;; (color-theme-clarity)
      (color-theme-hober)))

;; ensure necessary libs are available on the PATH because MacOS
;; doesn't make this intuitive or easy
(setenv "PATH" (concat (expand-file-name "~/local/maven/bin") ":/opt/local/bin:/opt/local/sbin:" 
		       (getenv "PATH")))

;; Use mdfind on MacOSX
(if (string-equal system-type "darwin") (setq locate-command "mdfind"))

;;; The way previous input should be matched in a shell
(defun my-previous-input-behavior ()
  (local-set-key "\M-p" 'comint-previous-matching-input-from-input))
(add-hook 'comint-mode-hook 'my-previous-input-behavior)

;;; Convenient shortcuts
(global-set-key (quote [f9]) (quote magit-status))
(global-set-key (quote [f8]) (quote browse-url-at-point))
(global-set-key (quote [f7]) (quote compile))
(global-set-key (quote [f4]) (quote browse-kill-ring))
(global-set-key (quote [f3]) (quote grep-find))

;;; Map goto-line to M-g
;(global-set-key "\M-g" 'goto-line)
;;; Make <home> be C-a without the whitespace
(global-set-key [(home)] 'back-to-indentation)

;;; smarter other-window
(require 'windmove)
(windmove-default-keybindings)

;;; For calendar lunar/solar stuff
(setq calendar-latitude 34.0)
(setq calendar-longitude -84.4)
(setq calendar-location-name "Roswell, GA")
