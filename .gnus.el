;;; Personal settings
(setq user-mail-address "jcrossley@redhat.com"
      mail-host-address "redhat.com"
      user-full-name "Jim Crossley"
      my-news-server "news.gmane.org"
      my-imap-server "mail.corp.redhat.com"
      my-smtp-server "smtp.corp.redhat.com"
      )

;;; Splitting rules
(setq nnmail-split-methods
      '(
        ("clojure"       "^\\(To\\|Cc\\):.*clojure")
        ("clojure"       "^\\(To\\|Cc\\):.*datomic")
        ("clojure"       "^\\(To\\|Cc\\):.*noir")
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
        (nnimap "redhat"
                (nnimap-address ,my-imap-server)
                (nnimap-stream ssl)
                (nnimap-inbox "INBOX")
                (nnimap-split-methods default))
        (nnml "local")))

;;; Gmail
(add-to-list 'gnus-secondary-select-methods 
             '(nnimap "gmail"
                      (nnimap-address "imap.gmail.com")
                      (nnimap-server-port 993)
                      (nnimap-stream ssl)
                      (nnimap-inbox "INBOX")
                      (nnimap-split-methods default)))

;;; Outbound email
(setq send-mail-function 'smtpmail-send-it)
(setq message-send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server my-smtp-server)

;;; Reduce prompting
(setq gnus-interactive-catchup nil)
(setq gnus-interactive-exit nil)

;;; Save sent mail
(setq gnus-message-archive-group "nnimap+redhat:Sent")

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
(setq gnus-posting-styles
      '((".*"
         (name "Jim Crossley"))
        ((header "To" ".*googlegroups.*")
         (From "Jim Crossley <jcrossley3@gmail.com>"))))

;;; Use one of these as my From address when replying
(setq message-alternative-emails
      (regexp-opt '("jim@crossleys.org" "jcrossley3@gmail.com" "jcrossley@redhat.com" "jcrossle@redhat.com")))

;;; Check mail backends automatically
(gnus-demon-add-scanmail)

;;; Use adaptive scoring
(setq gnus-use-adaptive-scoring t)
