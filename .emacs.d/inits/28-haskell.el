(use-package haskell-mode
  :hook
  (haskell-mode . flycheck-mode)
  :custom
  (haskell-stylish-on-save t))

(use-package lsp-haskell)
