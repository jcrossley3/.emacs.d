(deftheme half-blind
  "Created 2013-05-17.")

(custom-theme-set-faces
 'half-blind
 '(default ((t (:inherit nil :background "white" :foreground "black" :width normal :foundry "unknown" :family "DejaVu Sans Mono" :height 135))))
 '(cursor ((t (:background "#000000"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((t (:family "Sans Serif"))))
 '(escape-glyph ((t (:foreground "brown"))))
 '(minibuffer-prompt ((t (:background "yellow" :foreground "#020697" :weight bold))))
 '(highlight ((t (:background "gray90"))))
 '(region ((t (:background "#b6b1f1" :foreground "black"))))
 '(shadow ((t (:foreground "grey50"))))
 '(secondary-selection ((t (:background "yellow1"))))
 '(trailing-whitespace ((t (:background "red1"))))
 '(font-lock-builtin-face ((t (:foreground "#170ce4"))))
 '(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face))))
 '(font-lock-comment-face ((t (:foreground "#777" :slant italic))))
 '(font-lock-constant-face ((t (:foreground "dark cyan"))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face))))
 '(font-lock-function-name-face ((t (:foreground "#0d27b5"))))
 '(font-lock-keyword-face ((t (:foreground "#5c5c5c"))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit bold))))
 '(font-lock-regexp-grouping-construct ((t (:inherit bold))))
 '(font-lock-string-face ((t (:foreground "#297f29" :slant italic))))
 '(font-lock-type-face ((t (:foreground "#0b7d07"))))
 '(font-lock-variable-name-face ((t (:foreground "#4f4047"))))
 '(font-lock-warning-face ((t (:inherit error :foreground "Red" :weight bold))))
 '(button ((t (:inherit link))))
 '(link ((t (:foreground "RoyalBlue3" :underline t))))
 '(link-visited ((t (:inherit link :foreground "magenta4"))))
 '(fringe ((t (:background "#ebebea"))))
 '(header-line ((t (:inherit mode-line :background "grey90" :foreground "grey20" :box nil))))
 '(tooltip ((t (:inherit variable-pitch :background "lightyellow" :foreground "black"))))
 '(mode-line ((t (:background "#3b6865" :foreground "#ffffff" :box (:line-width -1 :style released-button)))))
 '(mode-line-buffer-id ((t (:weight bold))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((t (:box (:line-width 2 :color "grey40" :style released-button)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "grey90" :foreground "grey20" :box (:line-width -1 :color "grey75") :weight light))))
 '(isearch ((t (:background "magenta3" :foreground "lightskyblue1"))))
 '(isearch-fail ((t (:background "RosyBrown1"))))
 '(lazy-highlight ((t (:background "paleturquoise"))))
 '(match ((t (:background "yellow1"))))
 '(next-error ((t (:inherit region))))
 '(query-replace ((t (:inherit isearch))))
 '(hl-line ((t (:background "paleturquoise" :weight extra-bold)))))

(provide-theme 'half-blind)
