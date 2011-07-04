;;; Personal settings
(setq user-mail-address "jcrossley@redhat.com"
      mail-host-address "redhat.com"
      user-full-name "Jim Crossley"
      my-news-server "news.gmane.org"
      my-imap-server "mail.corp.redhat.com"
      my-smtp-server "smtp.corp.redhat.com"
      )

;;; Splitting rules
(setq nnimap-split-inbox
      '("inbox"))
(setq nnimap-split-rule
      '(
        ("aquamacs"      "^\\(To\\|Cc\\):.*macosx-emacs")
        ("torquebox"     "^\\(To\\|Cc\\):.*torquebox")
        ("steamcannon"   "^\\(To\\|Cc\\):.*steamcannon")
        ("android"       "^\\(To\\|Cc\\):.*android")
        ("jboss"         "^\\(To\\|Cc\\):.*jboss-as7-dev")
        ))

;;; Primary news server
(setq gnus-select-method `(nntp ,my-news-server))

;;; Secondary (email)
(setq gnus-secondary-select-methods
      `(
        (nnimap "remote"
                (nnimap-address ,my-imap-server)
                (nnimap-stream ssl)
                )
        (nnml "local")
        )
      )

;;; Outbound email
(setq send-mail-function 'smtpmail-send-it)
(setq message-send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server my-smtp-server)

;;; Reduce prompting
(setq gnus-interactive-catchup nil)
(setq gnus-interactive-exit nil)

;;; Save sent mail
(setq gnus-message-archive-group "nnimap+remote:Sent")

;;; Only display groups with unread articles
(setq gnus-list-groups-with-ticked-articles nil)

;;; Delete read messages automatically after 14 days
(setq gnus-total-expirable-newsgroups ".")
(setq nnmail-expiry-wait 14)

;;; Prevent gnus from putting this in my custom-file
(setq canlock-password my-canlock-password)

;;; Look up email addresses in LDAP
(eval-after-load "message"
  '(define-key message-mode-map (kbd "TAB") 'eudc-expand-inline))
(setq eudc-ldap-attributes-translation-alist '((lastname . sn)
					       (firstname . givenname)
					       (email . mail)
					       (phone . telephonenumber)
					       (nickname . rhatknownas)))
(setq eudc-inline-query-format '((nickname) (firstname) (lastname) (firstname lastname)))
(setq eudc-inline-expansion-format '("%s <%s>" cn email))

;;; Posting styles
;; (setq gnus-posting-styles
;;       '((".*"
;;          (name "Jim Crossley"))
;;         ((header "Subject" "testing")
;;          (From "Jim Crossley <jim@crossleys.org>"))))

