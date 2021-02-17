(require 'erc)
(require 'erc-match)
(require 'erc-join)
(require 'erc-hl-nicks)
(require 'notifications)

(setq
 erc-interpret-mirc-color        t
 erc-nicklist-use-icons          nil
 erc-track-exclude-types         '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                   "324" "329" "332" "333" "353" "477")
 erc-track-exclude-server-buffer t
 erc-track-showcount             t
 erc-track-shorten-aggressively  t
 erc-hide-list                   '("MODE" "KICK")
 erc-current-nick-highlight-type 'all
 erc-keyword-highlight-type      'keyword
 erc-pal-highlight-type          'all
 erc-log-matches-flag            t
 erc-autojoin-mode               t
 erc-auto-set-away               t
 erc-autoaway-idle-seconds       7200
 erc-auto-discard-away           nil
 erc-nick-uniquifier             "_"
 erc-mode-line-format            "%S %a"
 erc-join-buffer                 'window-noselect
 erc-track-switch-direction      'importance
 erc-hl-nicks-skip-faces         nil ;'("erc-notice-face" "erc-pal-face" "erc-fool-face")
 erc-modules                     '(autoaway autojoin button completion fill irccontrols
                                   keep-place list log match menu move-to-prompt
                                   netsplit networks noncommands readonly ring
                                   stamp track hl-nicks))

;; flyspell check as I type
(erc-spelling-mode 1)

;;; set channel keywords and pals from alists in private.el.gpg
(defun jc/irc-matches ()
  (make-local-variable 'erc-keywords)
  (setq erc-keywords (or (cdr (assoc (erc-default-target) jc/channel-keywords-alist))
                         (cdr (assoc "default" jc/channel-keywords-alist))))
  (make-local-variable 'erc-pals)
  (setq erc-pals (or (cdr (assoc (erc-default-target) jc/channel-pals-alist))
                     (cdr (assoc "default" jc/channel-pals-alist)))))
(add-hook 'erc-join-hook 'jc/irc-matches)

;; highlight private queries in the mode line as if my nick is mentioned
(defadvice erc-track-find-face (around jc/erc-track-find-face-promote-query activate)
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

;;; shortcut for querying users
(define-key erc-mode-map (kbd "C-c q")
  (lambda (nick)
    (interactive (list (completing-read "Query nick: " erc-channel-users)))
    (erc-cmd-QUERY nick)))

;;; construct prompt from the channel name
(setq erc-prompt
      (lambda ()
        (let ((props '(read-only t rear-nonsticky t front-nonsticky t)))
          (if (and (boundp 'erc-default-recipients) (erc-default-target))
              (apply 'erc-propertize (concat (erc-default-target) ">") props)
            (apply 'erc-propertize "ERC>" props)))))

;;; put the number of channel users in the modeline
(define-minor-mode ncm-mode "Display number of channel members in modeline" nil
  (:eval
   (if erc-channel-users (format " %S" (hash-table-count erc-channel-users)))))
(add-hook 'erc-mode-hook 'ncm-mode)

(defun jc/erc-growl (match-type nick message)
  "Shows a growl notification, when user's nick was mentioned."
  (unless (posix-string-match "^\\*\\*\\* " message)
    (let ((who (substring nick 0 (string-match "!" nick)))
          (where (buffer-name (current-buffer))))
      (when (eq match-type 'current-nick)
        (notifications-notify
         :title (concat "<" who "> on " where)
         :body message)))))
(add-hook 'erc-text-matched-hook 'jc/erc-growl)

;;; prefer SPC/DEL to page UP/DOWN
(defun jc/erc-space ()
  (interactive)
  (if (<= (point) erc-input-marker)
      (condition-case nil
          (scroll-up)
        (error (end-of-buffer)
               (recenter)))
    (insert " ")))
(defun jc/erc-backspace ()
  (interactive)
  (if (> (point) erc-input-marker)
      (delete-backward-char 1)
    (scroll-down)))
(define-key erc-mode-map (kbd "SPC") 'jc/erc-space)
(define-key erc-mode-map (kbd "DEL") 'jc/erc-backspace)

;; Clears out annoying erc-track-mode stuff for when we don't care.
(defun jc/erc-reset-track-mode ()
  (interactive)
  (setq erc-modified-channels-alist nil)
  (erc-modified-channels-display)
  (force-mode-line-update t))

(defun connect-redhat ()
  (interactive)
  (erc :server "irc-2.devel.redhat.com" :port 6667 :nick erc-nick))
(defun connect-freenode ()
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick erc-nick))
(defun connect-all ()
  (interactive)
  (connect-redhat)
  (connect-freenode))

(define-key erc-mode-map (kbd "C-c m")
  (lambda (nick)
    (interactive (list (completing-read "Say 'morning!' to nick: " erc-channel-users)))
    (erc-send-message (format "%s: morning!" nick))))

(defun jc/erc-server-join-channel (f server channel &optional secret)
  (let ((srvr (if (and erc-autojoin-domain-only
                       (string-match "[^.\n]+\\.\\([^.\n]+\\.[^.\n]+\\)$" server))
                  (match-string 1 server)
		server)))
    (funcall f srvr channel)))
(advice-add 'erc-server-join-channel :around #'jc/erc-server-join-channel)

(add-hook 'erc-mode-hook 'company-mode)
