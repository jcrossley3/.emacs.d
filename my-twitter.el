
(require 'twittering-mode)
(setq twittering-username "jcrossley3")
(setq twittering-use-master-password t)
(add-hook 'twittering-mode-hook 
	  (lambda () 
	    (setq twittering-fill-column (min 100 (window-width)))))
