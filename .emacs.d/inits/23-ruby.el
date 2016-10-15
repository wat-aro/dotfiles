(use-package ruby-mode
  :interpreter (("ruby" . ruby-mode))
  :config
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (setq flycheck-checker 'ruby-rubocop)
               (flycheck-mode 1)
               (setq ruby-deep-indent-paren nil)))
    (use-package ruby-block
      :config
      (ruby-block-mode t))
    ;; (use-package ruby-electric
    ;;   :config
    ;;   (ruby-electric-mode t)
  (use-package rcodetools
    :config
    (bind-key "C-c d" 'xmp ruby-mode-map)
    (flycheck-mode t)))

(setq ruby-deep-indent-paren nil)
(use-package rubocop
  :init
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (rubocop-mode t)
               (flycheck-define-checker ruby-rubocop
                 "A Ruby syntax and style checker using the RuboCop tool."
                 :command ("rubocop" "--format" "emacs"
                           (config-file "--config" flycheck-rubocoprc)
                           source)
                 :error-patterns
                 ((warning line-start
                           (file-name) ":" line ":" column ": " (or "C" "W") ": " (messae)
                           line-end)
                  (error line-start
                         (file-name) ":" line ":" column ": " (or "E" "F") ": " (message)
                         line-end)))
               (setq flycheck-checker 'ruby-rubocop)
               (setq ruby-block-highlight-toggle t)
               (flycheck-mode 1))))

(setq ruby-insert-encoding-magic-comment nil)

(use-package inf-ruby :defer t
  :init
  (add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)
  :config
  (custom-set-variables
   '(inf-ruby-default-implementation "pry")
   '(inf-ruby-eval-binding "Pry.toplevel_binding")))

(use-package robe :defer t
  :init
  (add-hook 'ruby-mode-hook 'robe-mode)
  (add-hook 'robe-mode-hook 'ac-robe-setup))

(use-package ac-robe-setup :defer t
  :commands (ac-robe-setup))
