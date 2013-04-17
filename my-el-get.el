(require 'el-get)
(setq el-get-sources
      '((:name htmlize
               :type emacswiki
               :features htmlize)
        (:name magit
               :build/darwin ("PATH=/Applications/MacPorts/Emacs.app/Contents/MacOS:$PATH make all")
               :features magit)
        (:name emacs-w3m
               :build/darwin ("autoconf" "./configure --with-emacs=/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs" "make"))
        (:name gist
               :type git
               :url "https://github.com/mcfunley/gist.el.git"
               :features gist)
        (:name color-theme-hober2
               :type http
               :features color-theme-hober2
               :compile "nothing"
               :url "http://edward.oconnor.cx/config/elisp/color-theme-hober2.el")
        ))

(setq my-packages
      (append
       '(el-get bbdb rinari yaml-mode yari markdown-mode twittering-mode maxframe todochiku erc-highlight-nicknames color-theme yasnippet org-mode clojure-mode)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)
