;;; does anyone really use this?
(tool-bar-mode -1)

;;; Preferred default font height (renders smaller on OSX)
(set-face-attribute 'default (not 'only-this-frame) :height 150)

;;; ooh, colors!
(if (require 'color-theme nil t)
    (progn
      (if (fboundp 'color-theme-initialize) (color-theme-initialize))
      (color-theme-hober2)))

;; Setup PATH 
(setenv "PATH" (shell-command-to-string "source ~/.bashrc; echo -n $PATH"))
;; Update exec-path with the contents of $PATH
(setq exec-path (append exec-path (split-string (getenv "PATH") ":")))
;; Grab other environment variables
(loop for var in (split-string (shell-command-to-string "source ~/.bashrc; env")) do
      (let* ((pair (split-string var "="))
	     (key (car pair))
	     (value (cadr pair)))
	(unless (getenv key)
	  (setenv key value))))

;; Use mdfind on MacOSX
(if (string-equal system-type "darwin") (setq locate-command "mdfind"))

;;; The way previous input should be matched in a shell
(defun my-previous-input-behavior ()
  (local-set-key "\M-p" 'comint-previous-matching-input-from-input))
(add-hook 'comint-mode-hook 'my-previous-input-behavior)

;;; Convenient shortcuts
(global-set-key (kbd "C-c m") 'magit-status)
(global-set-key (kbd "C-c b") 'browse-url-at-point)
(global-set-key (kbd "C-c c") 'mvn)
(global-set-key (kbd "C-c k") 'browse-kill-ring)
(global-set-key (kbd "C-c g") 'rgrep)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key "d" 'dictionary-search)
;(global-set-key "\M-g" 'goto-line)

;;; smarter other-window
(require 'windmove)
(windmove-default-keybindings)

;;; For calendar lunar/solar stuff
(setq calendar-latitude 34.0)
(setq calendar-longitude -84.4)
(setq calendar-location-name "Roswell, GA")

;;; Ignore case when completing selection input
(setq completion-ignore-case t)
