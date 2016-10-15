;; Auto-Complete
(use-package auto-complete
  :diminish auto-complete-mode
  :config
  (add-to-list 'ac-dictionary-directories (locate-user-emacs-file "./ac-dict"))
  (require 'auto-complete-config)
  (ac-config-default)
  (global-auto-complete-mode t)
  (bind-key "M-n" 'ac-next)
  (bind-key "M-p" 'ac-previous)
  (setq ac-auto-show-menu 0.5)
  (setq ac-menu-height 20)
  (setq ac-use-fuzzy t))
