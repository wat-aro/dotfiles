(use-package ruby-mode
  :interpreter (("ruby" . ruby-mode))
  :config
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (setq ruby-deep-indent-paren nil)))
    (use-package ruby-block
      :config
      (ruby-block-mode t))
  (use-package rcodetools
    :config
    (bind-key "C-c d" 'xmp ruby-mode-map)))

(setq ruby-insert-encoding-magic-comment nil)

(use-package inf-ruby :defer t
  :init
  (add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)
  :config
  (custom-set-variables
   '(inf-ruby-default-implementation "pry")
   '(inf-ruby-console-rails-default-implementation "pry")
   '(inf-ruby-eval-binding "Pry.toplevel_binding")))

(use-package robe :defer t
  :init
  (add-hook 'ruby-mode-hook 'robe-mode)
  (add-hook 'robe-mode-hook 'ac-robe-setup))

(use-package ac-robe-setup :defer t
  :commands (ac-robe-setup))
