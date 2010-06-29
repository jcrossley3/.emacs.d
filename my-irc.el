
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
     (concat "ERC: name mentioned on: " (buffer-name (current-buffer)))
     message
     )))
(add-hook 'erc-text-matched-hook 'growl-when-mentioned)

(define-key erc-mode-map (kbd "C-c q")
  (lambda (nick)
    (interactive (list (completing-read "Nick: " erc-channel-users)))
    (erc-cmd-QUERY nick)))

