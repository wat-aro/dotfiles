;; Auto-Complete
(use-package auto-complete
  :diminish auto-complete-mode
  :config
  (add-to-list 'ac-dictionary-directories (locate-user-emacs-file "./ac-dict"))
  (require 'auto-complete-config)
  (ac-config-default)
  (setq ac-use-menu-map t)
  (bind-key "C-n" 'ac-next ac-menu-map)
  (bind-key "C-p" 'ac-previous ac-menu-map)
  (setq ac-auto-show-menu 0.5)
  (setq ac-menu-height 20)
  (setq ac-use-fuzzy t))

(use-package company
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 2
        company-selection-wrap-around t)

  (bind-keys :map company-mode-map
             ("M-i" . company-complete))
  (bind-keys :map company-active-map
             ("C-n" . company-select-next)
             ("C-p" . company-select-previous)
             ("C-s" . company-search-words-regexp))
  (bind-keys :map company-search-map
             ("C-n" . company-select-next)
             ("C-p" . company-select-previous)))
