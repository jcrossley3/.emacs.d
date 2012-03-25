
(require 'erc)

(defun connect-redhat ()
  (interactive)
  (erc :server "irc-2.devel.redhat.com" :port 6667 :nick "jcrossley3" :full-name "Jim Crossley"))
(defun connect-freenode ()
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "jcrossley3" :password my-freenode-password :full-name "Jim Crossley"))
(defun connect-all ()
  (interactive)
  (connect-redhat)
  (connect-freenode))

(defun growl-when-mentioned (match-type nick message)
  "Shows a growl notification, when user's nick was mentioned."
  (unless (posix-string-match "^\\** *Users on #" message)
    (let ((who (substring nick 0 (string-match "!" nick)))
          (where (buffer-name (current-buffer))))
      (when (eq match-type 'current-nick)
        (growl (concat "<" who "> on " where) message)))))
(add-hook 'erc-text-matched-hook 'growl-when-mentioned)

(define-key erc-mode-map (kbd "C-c q")
  (lambda (nick)
    (interactive (list (completing-read "Nick: " erc-channel-users)))
    (erc-cmd-QUERY nick)))

(define-key erc-mode-map (kbd "C-c l") (lambda () (interactive) (erc-cmd-LIST)))

;;; I prefer SPC/DEL to page UP/DOWN
(defun at-erc-prompt ()
  (save-excursion
    (beginning-of-line)
    (looking-at "ERC>")))
(defun my-erc-space ()
  (interactive)
  (if (at-erc-prompt)
      (if (looking-at "ERC>") (end-of-line) (self-insert-command 1))
    (condition-case nil
        (scroll-up)
      (error (end-of-buffer)
             (recenter)))))
(defun my-erc-backspace ()
  (interactive)
  (if (at-erc-prompt)
      (delete-backward-char 1)
    (scroll-down)))
(define-key erc-mode-map (kbd "SPC") 'my-erc-space)
(define-key erc-mode-map (kbd "DEL") 'my-erc-backspace)

(defun my-channel-keywords () 
  (make-local-variable 'erc-keywords)
  (let ((buf (buffer-name)))
    (cond ((string-match "^#jboss" buf) 
	   (setq erc-keywords '("immutant" "torquebox")))
	  ((string-match "^#emacs" buf) 
	   (setq erc-keywords '("eudc" "emms" "gnus")))
	  ((string-match "^#clojure" buf) 
	   (setq erc-keywords '("immutant" "enterprise")))
	  (nil))))
(add-hook 'erc-join-hook 'my-channel-keywords)

; (setq erc-pals nil)
(setq erc-pals (quote ("bobmcw" "mgoldmann" "bbrowning" "tcrawley" "lanceball" "msavy")))

