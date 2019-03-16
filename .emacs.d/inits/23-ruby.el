
(use-package ruby-mode
  :interpreter (("ruby" . ruby-mode))
  :custom
  (ruby-deep-indent-paren nil)
  (ruby-insert-encoding-magic-comment nil))

;; inf-ruby
(use-package inf-ruby :defer t
  :hook
  (inf-ruby-mode . ansi-color-for-comint-mode-on)
  :custom
  (inf-ruby-default-implementation "pry")
  (inf-ruby-eval-binding "Pry.toplevel_binding"))

;; robe
(use-package robe :defer t
  :init
  :config
  (ac-robe-setup)
  :hook
  (ruby-mode . robe-mode))

(use-package ac-robe-setup :defer t
  :hook
  (robe-mode . ac-robe-setup)
  :commands (ac-robe-setup))

;; RSpec
(use-package rspec-mode
  :hook
  (after-init . inf-ruby-switch-setup)
  :custom
  (compilation-scroll-output t)
  :config
  (rspec-install-snippets))

(use-package rbenv
  :init
  (global-rbenv-mode)
  :custom
  (rbenv-show-active-ruby-in-modeline nil))

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
