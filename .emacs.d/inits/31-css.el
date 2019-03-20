;; Emmet-mode
(use-package emmet-mode :defer t
  :hook
  ((web-mode css-mode) . emmet-mode)
  :bind (:map emmet-mode-keymap
         ("C-c j" . emmet-expand-line)
         ("C-c j  . nil")))
