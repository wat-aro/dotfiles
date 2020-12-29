(use-package haskell-mode :defer t
  :hook
  (haskell-mode . flycheck-mode)
  :custom
  (haskell-stylish-on-save t))

(use-package lsp-haskell :defer t)
