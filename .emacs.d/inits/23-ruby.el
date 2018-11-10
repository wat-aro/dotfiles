
(use-package ruby-mode
  :interpreter (("ruby" . ruby-mode))
  :init
  (custom-set-variables '(ruby-deep-indent-paren nil)
                        '(ruby-insert-encoding-magic-comment nil))
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (flycheck-mode 1)
               ))
  :config
  ;; (setq flycheck-command-wrapper-function
  ;;     (lambda (command)
  ;;       (append '("bundle" "exec") command)))
  )

;; inf-ruby
(use-package inf-ruby :defer t
  :init
  (add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)
  :config
  (custom-set-variables
   '(inf-ruby-default-implementation "pry")
   '(inf-ruby-eval-binding "Pry.toplevel_binding")))


;; robe
(autoload 'ac-robe-setup "ac-robe" "auto-complete robe" nil nil)
(use-package robe :defer t
  :init
  (add-hook 'ruby-mode-hook 'robe-mode))

(use-package ac-robe-setup :defer t
  :init
  (add-hook 'robe-mode-hook 'ac-robe-setup)
  :commands (ac-robe-setup))

;; RSpec
(use-package rspec-mode
  :init
  (add-hook 'after-init-hook 'inf-ruby-switch-setup)
  :config
  (setq compilation-scroll-output t)
  (rspec-install-snippets))

(use-package rbenv
  :init
  (custom-set-variables '(rbenv-show-active-ruby-in-modeline nil))
  (global-rbenv-mode))

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
