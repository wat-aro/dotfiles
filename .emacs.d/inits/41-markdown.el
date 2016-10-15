;; Markdown Mode
(use-package markdown-mode :defer t
  :mode ("\\.md\\'" . gfm-mode)
  :config
  (custom-set-variables
   '(markdown-indent-on-enter nil)
   '(markdown-make-gfm-checkboxes-buttons))
  (visual-line-mode nil)
  (bind-keys :map markdown-mode-map
             ("C-M-i" . auto-complete)
             ("C-c C-c C-l" . markdown-insert-link)
             ("C-c C-c C-i" . markdown-insert-image)
             ("C-c C-c C-c" . markdown-insert-gfm-code-block)))