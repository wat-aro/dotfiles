(use-package ruby-mode :defer t
  :interpreter (("ruby" . ruby-mode))
  :custom
  (ruby-deep-indent-paren nil)
  (ruby-insert-encoding-magic-comment nil)
  (lsp-solargraph-use-bundler t))

(use-package ruby-electric :defer t
  :hook
  (ruby-mode . (lambda () (ruby-electric-mode t))))

;; inf-ruby
(use-package inf-ruby :defer t
  :hook
  (inf-ruby-mode . ansi-color-for-comint-mode-on)
  :custom
  (inf-ruby-default-implementation "pry")
  (inf-ruby-eval-binding "Pry.toplevel_binding"))

;; RSpec
(use-package rspec-mode :defer t
  :hook
  (after-init . inf-ruby-switch-setup)
  :custom
  (compilation-scroll-output t)
  :config
  (rspec-install-snippets))

(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(use-package projectile-rails
  :init
  (projectile-rails-global-mode)
  (define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map))

(use-package rinari :defer t
  :hook
  (ruby-mode . rinari-minor-mode))

(use-package rubocop :defer t
  :hook
  (ruby-mode . rubocop-mode)
  :custom
  (rubocop-keymap-prefix (kbd "C-c ."))
  (rubocop-autocorrect-on-save t))
