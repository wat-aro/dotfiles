;; Auto-Complete
(use-package auto-complete
  :diminish auto-complete-mode
  :custom
  (ac-auto-show-menu 0.5)
  (ac-menu-height 20)
  (ac-use-fuzzy t)
  (ac-use-menu-map t)
  :config
  (add-to-list 'ac-dictionary-directories (locate-user-emacs-file "./ac-dict"))
  (require 'auto-complete-config)
  (ac-config-default)
  :bind (:map ac-menu-map
              ("C-n" . ac-next )
              ("C-p" . ac-previous)))

(use-package company
  :custom
  (company-idle-delay 0.1)
  (company-minimum-prefix-length 2)
  (company-selection-wrap-around t)
  :bind (:map company-mode-map
         ("M-i" . company-complete)
         :map company-active-map
         ("M-n" . company-select-next)
         ("M-p" . company-select-previous)
         ("M-s" . company-search-words-regexp)
         :map company-search-map
         ("M-n" . company-select-next)
         ("M-p" . company-select-previous)))
