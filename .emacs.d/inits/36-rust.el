(use-package rust-mode
  :custom
  (rust-format-on-save t)
  :hook
  (rust-mode . racer-mode)
  (racer-mode . eldoc-mode)
  (racer-mode . (lambda ()
                  (company-mode)
                  (set (make-variable-buffer-local 'company-idle-delay) 0.1)
                  (set (make-variable-buffer-local 'company-minimum-prefix-length) 0))))
