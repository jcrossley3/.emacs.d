;; el-get
(setq el-get-sources
      '(el-get
        yaml-mode
        markdown-mode
        (:name htmlize
               :type emacswiki
               :features htmlize)
        (:name magit
               :build/darwin ("PATH=/Applications/MacPorts/Emacs.app/Contents/MacOS:$PATH make all")
               :features magit)
        (:name bbdb
               :build/darwin ("./configure --with-emacs=/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs" "make autoloads" "make"))
        (:name emacs-w3m
               :build/darwin ("autoconf" "./configure --with-emacs=/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs" "make"))
        twittering-mode
        maxframe
        (:name package
               :compile "package.el")
        (:name gist
               :type git
               :url "https://github.com/mcfunley/gist.el.git"
               :features gist)
        todochiku
        erc-highlight-nicknames
        (:name color-theme-hober2
               :type http
               :features color-theme-hober2
               :compile "nothing"
               :url "http://edward.oconnor.cx/config/elisp/color-theme-hober2.el")
        ))
