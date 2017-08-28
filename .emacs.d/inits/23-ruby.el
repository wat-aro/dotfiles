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

(use-package rspec-mode
  :init
  (add-hook 'after-init-hook 'inf-ruby-switch-setup)
  :config
  (rspec-install-snippets))
