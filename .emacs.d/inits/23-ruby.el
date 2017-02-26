(use-package ruby-mode
  :interpreter (("ruby" . ruby-mode))
  :init
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (setq ruby-deep-indent-paren nil)
               (setq flycheck-checker 'ruby-rubocop)
               (flycheck-mode 1)))
  :config
  (use-package rcodetools
    :config
    (bind-key "C-c d" 'xmp ruby-mode-map)))

(setq ruby-deep-indent-paren nil)

(setq ruby-insert-encoding-magic-comment nil)

;; inf-ruby
(use-package inf-ruby :defer t
  :init
  (add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)
  :config
  (custom-set-variables
   '(inf-ruby-default-implementation "pry")
   '(inf-ruby-eval-binding "Pry.toplevel_binding")))


;; robe
;; (autoload 'ac-robe-setup "ac-robe" "auto-complete robe" nil nil)
(use-package robe :defer t
  :init
  (add-hook 'ruby-mode-hook 'robe-mode))

(use-package ac-robe-setup :defer t
  :init
  (add-hook 'robe-mode-hook 'ac-robe-setup)
  :commands (ac-robe-setup))
