;;; Personal settings
(setq user-mail-address "jcrossley@redhat.com"
      mail-host-address "redhat.com"
      user-full-name "Jim Crossley"
      )

;;; Primary news server
(setq gnus-select-method '(nntp "nntp.charter.net"))

;;; Secondary
(setq gnus-secondary-select-methods
      '(
        (nnimap "redhat"
                (nnimap-address "mail.corp.redhat.com")
                (nnimap-stream ssl)
                )
        (nnml "local")
        )
      )

;;; Splitting rules
(setq nnimap-split-inbox
      '("inbox"))
(setq nnimap-split-rule
      '(
        ("aquamacs"      "^\\(To\\|Cc\\):.*macosx-emacs")
        ))

;;; Reduce prompting
(setq gnus-interactive-catchup nil)
(setq gnus-interactive-exit nil)

;;; Save sent mail
(setq gnus-message-archive-group "nnimap+redhat:Sent")

;;; Only display groups with unread articles
(setq gnus-list-groups-with-ticked-articles nil)

;;; Posting styles
;; (setq gnus-posting-styles
;;       '((".*"
;;          (name "Jim Crossley"))
;;         ((header "Subject" "testing")
;;          (From "Jim Crossley <jim@crossleys.org>"))))

