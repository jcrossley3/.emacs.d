;; el-get
(setq el-get-sources
      '(el-get
        (:name magit
               :build/darwin ("PATH=/Applications/MacPorts/Emacs.app/Contents/MacOS:$PATH make all"))
        (:name bbdb
               :build/darwin ("./configure --with-emacs=/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs" "make autoloads" "make"))
        (:name emacs-w3m
               :build/darwin ("autoconf" "./configure --with-emacs=/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs" "make"))
        twittering-mode
        maxframe
        (:name package
               :compile "package.el")
        gist
        todochiku
        erc-highlight-nicknames
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

