(use-package rust-mode :defer t
  :ensure t
  :custom rust-format-on-save t
  :bind
  (:map rust-mode-map ("C-m" . newline-and-open-blacket)))

(use-package cargo :defer t
  :ensure t
  :hook (rust-mode . cargo-minor-mode))
