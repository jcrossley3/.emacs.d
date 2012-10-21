(require 'twittering-mode)

(setq twittering-username "jcrossley3")
(setq twittering-use-master-password t)
(setq twittering-retweet-format "RT @%s: %t")

(twittering-icon-mode 1)
(add-hook 'twittering-mode-hook 
          (lambda () 
            (setq twittering-fill-column (min 100 (window-width)))))
