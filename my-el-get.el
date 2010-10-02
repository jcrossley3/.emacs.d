;; el-get
(setq el-get-sources
      '(el-get
        magit
        bbdb
        emacs-w3m
        twittering-mode
        maxframe
        package
        todochiku
        erc-highlight-nicknames
        (:name rinari
               :compile ("\.el$"))
        (:name color-theme-hober2
               :type http
               :features color-theme-hober2
               :compile "nothing"
               :url "http://edward.oconnor.cx/config/elisp/color-theme-hober2.el")
        ))
;; el-get
(add-to-list 'load-path (concat my-config-dir "el-get/el-get"))
(if (require 'el-get nil t)
    (el-get)
  (message "You need to install el-get"))

