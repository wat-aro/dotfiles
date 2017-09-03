(use-package rust-mode
  :init
  (add-hook 'rust-mode-hook
            (lambda ()
              (racer-mode)
              (flycheck-rust-setup)))
  (add-hook 'racer-mode-hook 'eldoc-mode)
  (add-hook 'racer-mode-hook
            (lambda ()
              (company-mode)
              (set (make-variable-buffer-local 'company-idle-delay) 0.1)
              (set (make-variable-buffer-local 'company-minimum-prefix-length) 0)))
  :config
  (setq-default rust-format-on-save t))
