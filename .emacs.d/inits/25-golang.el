(use-package go-mode :ensure t
  :mode
  ("\\.go\\'" . go-mode)
  :init
  (add-hook 'before-save-hook 'lsp-format-buffer)
  (add-hook 'before-save-hook 'lsp-organize-imports))

