(use-package ruby-mode
  :interpreter (("ruby" . ruby-mode))
  :init (add-hook 'ruby-mode-hook
            '(lambda ()
               (setq flycheck-checker 'ruby-rubocop)
               (flycheck-mode 1)
               (setq ruby-deep-indent-paren nil)))
  :bind (("C-c C-a" . 'ruby-))
  :config
    (use-package ruby-block
      :config
      (ruby-block-mode t))
  (use-package rcodetools
    :config
    (bind-key "C-c d" 'xmp ruby-mode-map)
    (flycheck-mode t))
  (setq ruby-deep-indent-paren nil))

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
