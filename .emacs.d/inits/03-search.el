;; anzu
(global-anzu-mode +1)
(custom-set-variables
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(custom-safe-themes
   (quote
    ("bdaab014ec6785f64b72efbea80808b762d8971247aacf2ffc6b76a39b9ed97c" default)))
 '(rspec-use-rake-when-possible nil)
 '(tab-width 2)
 '(anzu-use-migemo t))

(use-package isearch
  :bind
  ("M-i" . helm-swoop))
