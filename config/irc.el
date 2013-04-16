(require 'erc)
(require 'erc-match)
(require 'erc-hl-nicks)

;; load private data - this doesn't go into git
(load "~/.emacs.d/private.el.gpg")

(setq
 erc-interpret-mirc-color        t
 erc-nicklist-use-icons          nil
 erc-track-exclude-types         '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                   "324" "329" "332" "333" "353" "477")
 erc-track-exclude-server-buffer t
 erc-track-showcount             t  
 erc-hide-list                   '("MODE" "KICK")
 erc-current-nick-highlight-type 'all
 erc-keyword-highlight-type      'keyword
 erc-pal-highlight-type          'all
 erc-log-matches-flag            t
 erc-auto-set-away               t
 erc-autoaway-idle-seconds       7200
 erc-auto-discard-away           nil
 erc-away-nickname               "jcrossley3-away"
 erc-nick                        "jcrossley3"
 erc-nick-uniquifier             "_"
 erc-mode-line-format            "%s %a. %n on %t (%m,%l)"
 erc-join-buffer                 'window-noselect
 erc-track-switch-direction      'importance
 erc-hl-nicks-skip-faces         nil ;'("erc-notice-face" "erc-pal-face" "erc-fool-face")
 erc-modules                     '(autoaway autojoin button completion fill irccontrols
                                   keep-place list log match menu move-to-prompt
                                   netsplit networks noncommands readonly ring
                                   stamp track hl-nicks))

;; flyspell check as I type
(erc-spelling-mode 1)

(add-hook 'erc-join-hook 'jc/irc-matches)

(defadvice erc-match-current-nick-p (around tc/erc-match-current-nick-p-sometimes activate)
  (and msg
       (not (string-match "\\*\\*\\* \\(Users on #\\|#.*: topic set\\)" msg))
       ad-do-it))

;; highlight queries in the mode line as if my nick is mentioned
(defadvice erc-track-find-face (around tc/erc-track-find-face-promote-query activate)
  (if (erc-query-buffer-p) 
      (setq ad-return-value (intern "erc-current-nick-face"))
    ad-do-it))

;;; change header line face if disconnected
(defface erc-header-line-disconnected
  '((t (:foreground "black" :background "indianred")))
  "Face to use when ERC has been disconnected.")

(setq erc-header-line-face-method
      (lambda ()
        "Use a different face in the header-line when disconnected."
        (erc-with-server-buffer
          (cond ((erc-server-process-alive) 'erc-header-line)
                (t 'erc-header-line-disconnected)))))

;; display # of members in mode line
(define-minor-mode ncm-mode "" nil
  (:eval
   (let ((ops 0)
         (voices 0)
         (members 0))
     (maphash (lambda (key value)
                (when (erc-channel-user-op-p key)
                  (setq ops (1+ ops)))
                (when (erc-channel-user-voice-p key)
                  (setq voices (1+ voices)))
                (setq members (1+ members)))
              erc-channel-users)
     (format " %S" members))))

(add-hook 'erc-mode-hook 'ncm-mode)

(defun tc/irc-growl (channel message)
  "Displays an irc message to growl/libnotify via todochiku.
Notice will be sticky if the message is a query."
  (let ((split-message (tc/irc-split-nick-and-message message)))
    (if split-message
        (notify (concat "<" (nth 0 split-message) "> on " channel)
         (tc/escape-html (nth 1 split-message))))))

(defun tc/irc-split-nick-and-message (msg)
  "Splits an irc message into nick and the rest of the message.
Assumes message is either of two forms: '* nick does something' or '<nick> says something'"
  (if (string-match "^[<\\*] ?\\(.*?\\)>? \\(.*\\)$" msg)
      (cons (match-string 1 msg)
            (cons (match-string 2 msg)
                  ()))
    ()))

(defun tc/irc-alert-on-message (channel msg)
  "Plays a sound and growl notifies a message."
  (and (string-match "^[*<][^*]" msg)
       (> (length msg) 0)
       (or (not (string-match "^#" channel)) ;; query
           (and (not (string-match "^*" msg)) ;; /me
                (string-match (erc-current-nick) msg)))
       (progn
         (tc/play-irc-alert-sound)
         (tc/irc-growl channel msg))))

(defun tc/irc-alert ()
  (save-excursion
    (tc/irc-alert-on-message (buffer-name) (buffer-substring (point-min) (point-max)))))

(add-hook 'erc-insert-post-hook 'tc/irc-alert)

(defun tc/play-irc-alert-sound ()
  (start-process-shell-command "alert-sound" nil
                               (if (eq system-type 'darwin)
                                   "say -v Zarvox -r 500 heyy"
                                 "mplayer /usr/share/sounds/purple/alert.wav")))

(defun tc/escape-html (str)
  "Escapes [<>&\n] from a string with html escape codes."
  (and str
       (replace-regexp-in-string "<" "&lt;"
         (replace-regexp-in-string ">" "&gt;"
           (replace-regexp-in-string "&" "&amp;"
             (replace-regexp-in-string "\n" "" str))))))

(define-key erc-mode-map (kbd "C-c q")
  (lambda (nick)
    (interactive (list (completing-read "Query nick: " erc-channel-users)))
    (erc-cmd-QUERY nick)))

(setq erc-prompt
      (lambda ()
        (if (and (boundp 'erc-default-recipients) (erc-default-target))
            (erc-propertize (concat (erc-default-target) ">") 'read-only t 'rear-nonsticky t 'front-nonsticky t)
          (erc-propertize (concat "ERC>") 'read-only t 'rear-nonsticky t 'front-nonsticky t))))


(defun tc/yank-to-gist ()
  "yank from the top of the kill ring, create a gist from it, and insert the gist url at the point"
  (interactive)
  (save-excursion
    (let ((buffer (current-buffer)))
            (set-buffer (get-buffer-create "*yank-to-gist*"))
            (yank)
            (gist-region
             (point-min)
             (point-max)
             t
             (lexical-let ((buf buffer))
               (function (lambda (status)
                           (let ((location (cadr status)))
                             (set-buffer buf)
                             (message "Paste created: %s" location)
                             (insert location)
                             (kill-new location))))))
            (kill-buffer))))

(define-key erc-mode-map (kbd "C-c y") `tc/yank-to-gist)

(defun tc/ido-erc-buffer()
  (interactive)
  (tc/ido-for-mode "Channel:" 'erc-mode))

(global-set-key (kbd "C-x c") 'tc/ido-erc-buffer)

;;; I prefer SPC/DEL to page UP/DOWN
(defun erc:at-prompt ()
  (save-excursion
    (forward-line 0)
    (looking-at "^#.+>")))
(defun erc:space ()
  (interactive)
  (if (erc:at-prompt)
      (if (looking-at "^#.+>")
          (progn
            (end-of-line)
            (recenter))
        (self-insert-command 1))
    (condition-case nil
        (scroll-up)
      (error (end-of-buffer)
             (recenter)))))
(defun erc:backspace ()
  (interactive)
  (if (erc:at-prompt)
      (delete-backward-char 1)
    (scroll-down)))
(define-key erc-mode-map (kbd "SPC") 'erc:space)
(define-key erc-mode-map (kbd "DEL") 'erc:backspace)

(defun connect-redhat ()
  (interactive)
  (erc :server "irc-2.devel.redhat.com" :port 6667 :nick "jcrossley3" :full-name "Jim Crossley"))
(defun connect-freenode ()
  (interactive)
  (erc :server "chat.freenode.net" :port 6667 :nick "jcrossley3" :password my-freenode-password :full-name "Jim Crossley"))
(defun connect-all ()
  (interactive)
  (connect-redhat)
  (connect-freenode))
