
(require 'erc)
(require 'todochiku)

(defun connect-redhat ()
  (interactive)
  (erc :server "irc-2.devel.redhat.com" :port 6667 :nick "jc3" :full-name "Jim Crossley"))
(defun connect-freenode ()
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "jc3" :password my-freenode-password :full-name "Jim Crossley"))
(defun connect-all ()
  (interactive)
  (connect-redhat)
  (connect-freenode))

(defun growl-when-mentioned (match-type nick message)
  "Shows a growl notification, when user's nick was mentioned."
  (unless (posix-string-match "^\\** *Users on #" message)
    (growl
     (concat "<" (substring nick 0 (string-match "!" nick)) "> on " (buffer-name (current-buffer)))
     message
     )))
(add-hook 'erc-text-matched-hook 'growl-when-mentioned)

(define-key erc-mode-map (kbd "C-c q")
  (lambda (nick)
    (interactive (list (completing-read "Nick: " erc-channel-users)))
    (erc-cmd-QUERY nick)))

;;; I prefer SPC/DEL to page UP/DOWN
(defun at-erc-prompt ()
  (save-excursion
    (beginning-of-line)
    (looking-at "ERC>")))
(defun my-erc-space ()
  (interactive)
  (if (at-erc-prompt)
      (self-insert-command 1)
    (condition-case nil
	(scroll-up)
      (error (end-of-buffer)))))
(defun my-erc-backspace ()
  (interactive)
  (if (at-erc-prompt)
      (delete-backward-char 1)
    (scroll-down)))
(define-key erc-mode-map (kbd "SPC") 'my-erc-space)
(define-key erc-mode-map (kbd "DEL") 'my-erc-backspace)
