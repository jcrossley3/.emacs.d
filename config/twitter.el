(require 'twittering-mode)

(setq twittering-username "jcrossley3")
(setq twittering-use-master-password t)
(setq twittering-retweet-format "RT @%s: %t")

(add-hook 'twittering-mode-hook 
          (lambda ()
            (twittering-icon-mode 1)
            (setq twittering-fill-column (min 100 (window-width)))))
