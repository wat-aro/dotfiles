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
 '(tab-width 2))

;;; migemo
(use-package migemo
  :init
  (custom-set-variables '(migemo-command "cmigemo")
                        '(migemo-options '("-q" "--emacs"))
                        '(migemo-dictionary "/usr/local/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict")
                        '(migemo-user-dictionary nil)
                        '(migemo-regex-dictionary nil)
                        '(migemo-coding-system 'utf-8))
  (load-library "migemo")
  (migemo-init))
